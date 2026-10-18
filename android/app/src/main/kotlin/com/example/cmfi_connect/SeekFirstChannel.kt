package com.example.cmfi_connect

import android.app.Activity
import android.app.AlertDialog
import android.app.AppOpsManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Build
import android.os.Process
import android.provider.Settings
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.CheckBox
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.ListView
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * The Android side of AppShield (lib/src/core/services/app_shield.dart,
 * channel cmficonnect/shield), the same methods as AppShield.swift: the two
 * special permissions (usage access, drawing over other apps), the apps to
 * keep closed (a list of the apps of the phone, with their icons), the
 * settings, the day unlocked, the pauses. SeekFirstService does the rest.
 */
class SeekFirstChannel(private val activity: Activity, messenger: BinaryMessenger) :
    MethodChannel.MethodCallHandler {

  private val store = SeekFirstStore(activity)
  private val channel = MethodChannel(messenger, "cmficonnect/shield")

  /** The answer to « authorize », given when the member comes back from the settings. */
  private var pendingAuthorize: MethodChannel.Result? = null

  init {
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "available" -> result.success(true)
      "authorized" -> result.success(authorized())
      "authorize" -> authorize(call, result)
      "selection" -> result.success(mapOf("apps" to store.packages.size))
      "choose" -> choose(call, result)
      "configure" -> {
        store.enabled = call.argument<Boolean>("enabled") ?: false
        store.startMinutes = call.argument<Int>("startMinutes") ?: 5 * 60
        store.pausesPerDay = call.argument<Int>("pausesPerDay") ?: 3
        call.argument<Map<String, String>>("texts")?.let { store.texts = it }
        SeekFirstService.sync(activity)
        result.success(null)
      }
      "unlock" -> {
        store.unlockedDay = call.argument<String>("day") ?: ""
        result.success(null)
      }
      "pausesLeft" -> result.success(store.pausesLeft())
      else -> result.notImplemented()
    }
  }

  private fun usageAccess(): Boolean {
    val ops = activity.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
    val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      ops.unsafeCheckOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), activity.packageName)
    } else {
      @Suppress("DEPRECATION")
      ops.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), activity.packageName)
    }
    return mode == AppOpsManager.MODE_ALLOWED
  }

  private fun overlay(): Boolean = Settings.canDrawOverlays(activity)

  private fun authorized(): Boolean = usageAccess() && overlay()

  /**
   * Explains the two permissions, then opens the settings of the first one
   * missing; [onResume] goes on with the next one, then answers.
   */
  private fun authorize(call: MethodCall, result: MethodChannel.Result) {
    if (authorized()) {
      result.success(true)
      return
    }
    val texts = call.argument<Map<String, String>>("texts") ?: emptyMap()
    pendingAuthorize?.success(false)
    AlertDialog.Builder(activity)
        .setTitle(texts["title"] ?: "Cherche d'abord Dieu")
        .setMessage(texts["text"] ?: "")
        .setPositiveButton(texts["continue"] ?: "OK") { _, _ ->
          pendingAuthorize = result
          openNextSettings()
        }
        .setNegativeButton(texts["cancel"] ?: "Annuler") { _, _ -> result.success(false) }
        .setOnCancelListener { result.success(false) }
        .show()
  }

  private var asked = mutableSetOf<String>()

  /** The settings page of the next permission missing; false when none is. */
  private fun openNextSettings(): Boolean {
    val uri = Uri.parse("package:${activity.packageName}")
    val intent = when {
      !usageAccess() && "usage" !in asked -> {
        asked.add("usage")
        Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS).apply {
          // opens the app's own line where the phone allows it
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) data = uri
        }
      }
      !overlay() && "overlay" !in asked -> {
        asked.add("overlay")
        Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, uri)
      }
      else -> return false
    }
    try {
      activity.startActivity(intent)
    } catch (_: Exception) {
      // a phone without the app's own line: the whole list
      activity.startActivity(Intent(intent.action))
    }
    return true
  }

  /** Back in the app (MainActivity.onResume): the next permission, or the answer. */
  fun onResume() {
    val result = pendingAuthorize ?: return
    if (!authorized() && openNextSettings()) return
    pendingAuthorize = null
    asked.clear()
    result.success(authorized())
  }

  /** The apps of the phone that open from the launcher, ours aside. */
  private data class App(val packageName: String, val label: String, val icon: Drawable)

  private fun launchableApps(): List<App> {
    val pm = activity.packageManager
    val main = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
    @Suppress("DEPRECATION")
    val activities = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
      pm.queryIntentActivities(main, PackageManager.ResolveInfoFlags.of(0))
    } else {
      pm.queryIntentActivities(main, 0)
    }
    return activities
        .map { it.activityInfo.packageName }
        .distinct()
        .filter { it != activity.packageName }
        .mapNotNull { name ->
          try {
            val info = pm.getApplicationInfo(name, 0)
            App(name, pm.getApplicationLabel(info).toString(), pm.getApplicationIcon(info))
          } catch (_: PackageManager.NameNotFoundException) {
            null
          }
        }
        .sortedBy { it.label.lowercase() }
  }

  /** The list of the apps, the chosen ones ticked; the new count, null when cancelled. */
  private fun choose(call: MethodCall, result: MethodChannel.Result) {
    val texts = call.argument<Map<String, String>>("texts") ?: emptyMap()
    val apps = launchableApps()
    val chosen = store.packages.toMutableSet()
    fun dp(value: Int) =
        TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, value.toFloat(), activity.resources.displayMetrics)
            .toInt()

    val adapter = object : BaseAdapter() {
      override fun getCount() = apps.size
      override fun getItem(position: Int) = apps[position]
      override fun getItemId(position: Int) = position.toLong()
      override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val app = apps[position]
        val row = (convertView as? LinearLayout) ?: LinearLayout(activity).apply {
          orientation = LinearLayout.HORIZONTAL
          setPadding(dp(20), dp(10), dp(16), dp(10))
          addView(ImageView(activity), LinearLayout.LayoutParams(dp(36), dp(36)))
          addView(
              TextView(activity).apply {
                setTextSize(TypedValue.COMPLEX_UNIT_SP, 16f)
                setPadding(dp(16), 0, dp(8), 0)
              },
              LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f).apply {
                gravity = android.view.Gravity.CENTER_VERTICAL
              })
          addView(CheckBox(activity).apply { isClickable = false; isFocusable = false })
          gravity = android.view.Gravity.CENTER_VERTICAL
        }
        (row.getChildAt(0) as ImageView).setImageDrawable(app.icon)
        (row.getChildAt(1) as TextView).text = app.label
        (row.getChildAt(2) as CheckBox).isChecked = app.packageName in chosen
        return row
      }
    }
    val list = ListView(activity).apply {
      this.adapter = adapter
      setOnItemClickListener { _, _, position, _ ->
        val name = apps[position].packageName
        if (!chosen.remove(name)) chosen.add(name)
        adapter.notifyDataSetChanged()
      }
    }
    var answered = false
    AlertDialog.Builder(activity)
        .setTitle(texts["title"] ?: "")
        .setView(list)
        .setPositiveButton(texts["done"] ?: "OK") { _, _ ->
          answered = true
          store.packages = chosen
          SeekFirstService.sync(activity)
          result.success(mapOf("apps" to chosen.size))
        }
        .setNegativeButton(texts["cancel"] ?: "Annuler") { _, _ ->
          answered = true
          result.success(null)
        }
        .setOnDismissListener { if (!answered) result.success(null) }
        .show()
  }
}

/** After a restart (or an update of the app): the watch again when it is on. */
class SeekFirstBootReceiver : BroadcastReceiver() {
  override fun onReceive(context: Context, intent: Intent) {
    when (intent.action) {
      Intent.ACTION_BOOT_COMPLETED, Intent.ACTION_MY_PACKAGE_REPLACED -> SeekFirstService.sync(context)
    }
  }
}

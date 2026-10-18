package com.example.cmfi_connect

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.net.Uri
import android.os.Bundle
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView

/**
 * What covers a closed app: night blue and gold like the app, its icon,
 * « Cherche d'abord Dieu », « <app> reste fermée jusqu'à ton compte rendu
 * d'aujourd'hui », then « Remplir mon compte rendu » (opens today's report
 * in CMFI Connect) and « Pause de 5 min (n/3) ». Back goes to the home
 * screen, not to the closed app. The texts come from the app, in its
 * language (SeekFirstStore.texts).
 */
class ShieldActivity : Activity() {

  private lateinit var store: SeekFirstStore

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    store = SeekFirstStore(this)
    window.statusBarColor = NIGHT
    window.navigationBarColor = NIGHT
    render()
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    setIntent(intent)
    render()
  }

  override fun onResume() {
    super.onResume()
    // opened since (report saved, pause): nothing to cover any more
    if (!store.isClosed()) finish()
  }

  private fun dp(value: Int): Int =
      TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, value.toFloat(), resources.displayMetrics)
          .toInt()

  private fun appName(packageName: String?): String {
    if (packageName == null) return store.text("thisApp", "Cette app")
    return try {
      val info = packageManager.getApplicationInfo(packageName, 0)
      packageManager.getApplicationLabel(info).toString()
    } catch (_: PackageManager.NameNotFoundException) {
      store.text("thisApp", "Cette app")
    }
  }

  private fun button(text: String, filled: Boolean, onClick: () -> Unit): Button =
      Button(this).apply {
        this.text = text
        isAllCaps = false
        setTextSize(TypedValue.COMPLEX_UNIT_SP, 17f)
        typeface = Typeface.DEFAULT_BOLD
        setTextColor(if (filled) Color.WHITE else GOLD_LIGHT)
        background = GradientDrawable().apply {
          cornerRadius = dp(16).toFloat()
          if (filled) setColor(GOLD) else setStroke(dp(2), GOLD_LIGHT)
        }
        setPadding(dp(16), dp(14), dp(16), dp(14))
        setOnClickListener { onClick() }
      }

  private fun render() {
    val app = appName(intent.getStringExtra(EXTRA_PACKAGE))
    val pauses = store.pausesLeft()
    val layout = LinearLayout(this).apply {
      orientation = LinearLayout.VERTICAL
      gravity = Gravity.CENTER
      setBackgroundColor(NIGHT)
      setPadding(dp(32), dp(48), dp(32), dp(48))
    }
    layout.addView(
        ImageView(this).apply {
          setImageResource(R.mipmap.ic_launcher)
          contentDescription = null
        },
        LinearLayout.LayoutParams(dp(88), dp(88)).apply { bottomMargin = dp(24) })
    layout.addView(
        TextView(this).apply {
          text = store.text("title", "Cherche d'abord Dieu")
          setTextColor(Color.WHITE)
          setTextSize(TypedValue.COMPLEX_UNIT_SP, 26f)
          typeface = Typeface.DEFAULT_BOLD
          gravity = Gravity.CENTER
        })
    layout.addView(
        TextView(this).apply {
          text = store.text("subtitle", "{app} reste fermée jusqu'à ton compte rendu d'aujourd'hui.")
              .replace("{app}", app)
          setTextColor(MUTED)
          setTextSize(TypedValue.COMPLEX_UNIT_SP, 17f)
          gravity = Gravity.CENTER
          setLineSpacing(0f, 1.25f)
        },
        LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT)
            .apply {
              topMargin = dp(12)
              bottomMargin = dp(40)
            })
    val full = LinearLayout.LayoutParams(
        LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT)
    layout.addView(
        button(store.text("fill", "Remplir mon compte rendu"), filled = true) { fillReport() }, full)
    if (pauses > 0) {
      layout.addView(
          button(
              store.text("pause", "Pause de 5 min ({n}/3)").replace("{n}", "$pauses"),
              filled = false) {
                if (store.startPause()) finish()
              },
          LinearLayout.LayoutParams(full).apply { topMargin = dp(12) })
    }
    layout.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE
    setContentView(layout)
  }

  /** Today's report in CMFI Connect (the app's own link, read by app_links). */
  private fun fillReport() {
    startActivity(
        Intent(Intent.ACTION_VIEW, Uri.parse("cmficonnect://open?to=reports/today"))
            .setPackage(packageName)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP))
    finish()
  }

  @Deprecated("Back goes home, not to the closed app")
  override fun onBackPressed() {
    goHome()
  }

  private fun goHome() {
    startActivity(
        Intent(Intent.ACTION_MAIN)
            .addCategory(Intent.CATEGORY_HOME)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
    finish()
  }

  companion object {
    const val EXTRA_PACKAGE = "package"
    private val NIGHT = Color.parseColor("#072D5A")
    private val GOLD = Color.parseColor("#E2A93B")
    private val GOLD_LIGHT = Color.parseColor("#F6D27A")
    private val MUTED = Color.parseColor("#B8D6F2")
  }
}

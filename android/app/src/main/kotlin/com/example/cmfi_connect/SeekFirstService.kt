package com.example.cmfi_connect

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager

/**
 * Keeps watch while « Cherche d'abord Dieu » is on: from the set hour until
 * the day's report is saved, it looks each second (screen on only) at the
 * app in front (usage access) and covers a chosen one with ShieldActivity
 * (drawing over other apps). Outside those hours it sleeps until the next
 * closing. A quiet notification says it is on (Android asks it of a service
 * that stays).
 */
class SeekFirstService : Service() {

  private val handler = Handler(Looper.getMainLooper())
  private lateinit var store: SeekFirstStore
  private var lastShielded: String? = null
  private var lastShieldedAt = 0L

  private val watch = object : Runnable {
    override fun run() {
      if (!store.enabled || store.packages.isEmpty()) {
        stopSelf()
        return
      }
      val now = System.currentTimeMillis()
      val delay = if (store.isClosed(now)) {
        if (screenOn()) check(now)
        CHECK_MILLIS
      } else {
        // asleep until the apps close (or the pause ends), a minute at most
        store.untilClosing(now).coerceIn(CHECK_MILLIS, 60_000L)
      }
      handler.postDelayed(this, delay)
    }
  }

  override fun onCreate() {
    super.onCreate()
    store = SeekFirstStore(this)
  }

  override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    val notification = notification()
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
      startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE)
    } else {
      startForeground(NOTIFICATION_ID, notification)
    }
    handler.removeCallbacks(watch)
    handler.post(watch)
    return START_STICKY
  }

  override fun onDestroy() {
    handler.removeCallbacks(watch)
    super.onDestroy()
  }

  override fun onBind(intent: Intent?): IBinder? = null

  private fun screenOn(): Boolean =
      (getSystemService(Context.POWER_SERVICE) as PowerManager).isInteractive

  /** The app in front, from the last few seconds of usage events. */
  private fun foreground(now: Long): String? {
    val usage = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
    val events = usage.queryEvents(now - 10_000L, now)
    val event = UsageEvents.Event()
    var last: String? = null
    while (events.hasNextEvent()) {
      events.getNextEvent(event)
      // ACTIVITY_RESUMED from Android 10, the same value as before
      @Suppress("DEPRECATION")
      if (event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND) {
        last = event.packageName
      }
    }
    return last
  }

  private fun check(now: Long) {
    val app = foreground(now) ?: return
    if (app == packageName || app !in store.packages) return
    // the shield just shown for this app: not again at once
    if (app == lastShielded && now - lastShieldedAt < 1_500L) return
    lastShielded = app
    lastShieldedAt = now
    startActivity(
        Intent(this, ShieldActivity::class.java)
            .putExtra(ShieldActivity.EXTRA_PACKAGE, app)
            .addFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_NO_ANIMATION))
  }

  private fun notification(): Notification {
    val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      manager.createNotificationChannel(
          NotificationChannel(
              CHANNEL_ID,
              store.text("title", "Cherche d'abord Dieu"),
              NotificationManager.IMPORTANCE_MIN))
    }
    val open = PendingIntent.getActivity(
        this,
        0,
        packageManager.getLaunchIntentForPackage(packageName),
        PendingIntent.FLAG_IMMUTABLE)
    val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      Notification.Builder(this, CHANNEL_ID)
    } else {
      @Suppress("DEPRECATION") Notification.Builder(this)
    }
    return builder
        .setSmallIcon(R.drawable.ic_notification)
        .setContentTitle(store.text("title", "Cherche d'abord Dieu"))
        .setContentText(store.text("serviceBody", ""))
        .setContentIntent(open)
        .setOngoing(true)
        .build()
  }

  companion object {
    private const val CHANNEL_ID = "seek_first_service"
    private const val NOTIFICATION_ID = 6330
    private const val CHECK_MILLIS = 1_000L

    /** Starts the watch when it is on, stops it when it is off. */
    fun sync(context: Context) {
      val store = SeekFirstStore(context)
      val intent = Intent(context, SeekFirstService::class.java)
      if (store.enabled && store.packages.isNotEmpty()) {
        try {
          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(intent)
          } else {
            context.startService(intent)
          }
        } catch (_: Exception) {
          // not allowed from the background now: the next launch starts it
        }
      } else {
        context.stopService(intent)
      }
    }
  }
}

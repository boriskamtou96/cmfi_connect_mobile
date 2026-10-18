package com.example.cmfi_connect

import android.content.Context
import android.content.SharedPreferences
import org.json.JSONObject
import java.util.Calendar

/**
 * « Cherche d'abord Dieu » on Android: the settings the app gives
 * (lib/src/core/services/app_shield.dart, channel cmficonnect/shield) and
 * what the day has used, kept in the app's own preferences so the service
 * and the shield screen read them without Flutter. The apps chosen are kept
 * here only, never sent.
 */
class SeekFirstStore(context: Context) {

  private val prefs: SharedPreferences =
      context.getSharedPreferences("seek_first", Context.MODE_PRIVATE)

  var enabled: Boolean
    get() = prefs.getBoolean("enabled", false)
    set(value) = prefs.edit().putBoolean("enabled", value).apply()

  /** From when the apps close each day, in minutes after midnight. */
  var startMinutes: Int
    get() = prefs.getInt("start_minutes", 5 * 60)
    set(value) = prefs.edit().putInt("start_minutes", value).apply()

  var pausesPerDay: Int
    get() = prefs.getInt("pauses_per_day", 3)
    set(value) = prefs.edit().putInt("pauses_per_day", value).apply()

  /** The package names of the apps chosen. */
  var packages: Set<String>
    get() = prefs.getStringSet("packages", emptySet()) ?: emptySet()
    set(value) = prefs.edit().putStringSet("packages", value.toSet()).apply()

  /** What the shield and the notification say, in the app language. */
  var texts: Map<String, String>
    get() {
      val json = JSONObject(prefs.getString("texts", "{}") ?: "{}")
      return json.keys().asSequence().associateWith { json.optString(it) }
    }
    set(value) = prefs.edit().putString("texts", JSONObject(value).toString()).apply()

  fun text(key: String, fallback: String): String =
      texts[key]?.takeIf { it.isNotEmpty() } ?: fallback

  /** The day whose report is saved ("2026-10-18"): open until the next one. */
  var unlockedDay: String
    get() = prefs.getString("unlocked_day", "") ?: ""
    set(value) = prefs.edit().putString("unlocked_day", value).apply()

  /** The end of the pause under way (milliseconds), 0 without one. */
  private var pauseUntil: Long
    get() = prefs.getLong("pause_until", 0)
    set(value) = prefs.edit().putLong("pause_until", value).apply()

  fun pausesLeft(now: Long = System.currentTimeMillis()): Int {
    val used = if (prefs.getString("pause_day", "") == dayKey(now)) prefs.getInt("pauses_used", 0) else 0
    return (pausesPerDay - used).coerceAtLeast(0)
  }

  /** Five minutes open, one of today's pauses; false when none is left. */
  fun startPause(now: Long = System.currentTimeMillis()): Boolean {
    val left = pausesLeft(now)
    if (left <= 0) return false
    prefs.edit()
        .putString("pause_day", dayKey(now))
        .putInt("pauses_used", pausesPerDay - left + 1)
        .putLong("pause_until", now + PAUSE_MILLIS)
        .apply()
    return true
  }

  /** Whether the apps chosen are closed at [now]. */
  fun isClosed(now: Long = System.currentTimeMillis()): Boolean {
    if (!enabled || packages.isEmpty()) return false
    if (now < pauseUntil) return false
    if (unlockedDay == dayKey(now)) return false
    return minutesOf(now) >= startMinutes
  }

  /** Milliseconds until the apps close today, 0 when they are (or open for the day). */
  fun untilClosing(now: Long = System.currentTimeMillis()): Long {
    if (now < pauseUntil) return pauseUntil - now
    val minutes = minutesOf(now)
    return if (minutes < startMinutes) (startMinutes - minutes) * 60_000L else 0L
  }

  companion object {
    const val PAUSE_MILLIS = 5 * 60_000L

    fun dayKey(millis: Long): String {
      val c = Calendar.getInstance().apply { timeInMillis = millis }
      return "%04d-%02d-%02d".format(
          c.get(Calendar.YEAR), c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH))
    }

    fun minutesOf(millis: Long): Int {
      val c = Calendar.getInstance().apply { timeInMillis = millis }
      return c.get(Calendar.HOUR_OF_DAY) * 60 + c.get(Calendar.MINUTE)
    }
  }
}

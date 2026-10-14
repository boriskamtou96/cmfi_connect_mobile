package com.example.cmfi_connect

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/**
 * The "Aujourd'hui" widget: today's report done or to fill in, and how far
 * the goals go. The app saves the values and the texts in its language
 * (lib/src/core/services/home_widgets.dart); the next day, the widget shows
 * "to fill in" by itself. It comes with Premium.
 */
class TodayWidgetProvider : HomeWidgetProvider() {

  override fun onUpdate(
      context: Context,
      appWidgetManager: AppWidgetManager,
      appWidgetIds: IntArray,
      widgetData: SharedPreferences,
  ) {
    for (id in appWidgetIds) {
      appWidgetManager.updateAppWidget(
          id, views(context, widgetData, appWidgetManager.getAppWidgetOptions(id)))
    }
  }

  // resized: the wide or the small layout
  override fun onAppWidgetOptionsChanged(
      context: Context,
      appWidgetManager: AppWidgetManager,
      appWidgetId: Int,
      newOptions: Bundle,
  ) {
    super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
    appWidgetManager.updateAppWidget(
        appWidgetId, views(context, HomeWidgetPlugin.getData(context), newOptions))
  }

  private fun views(context: Context, data: SharedPreferences, options: Bundle): RemoteViews {
    val wide = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH) >= 250
    val views =
        RemoteViews(
            context.packageName, if (wide) R.layout.today_widget_wide else R.layout.today_widget)
    fun text(key: String) = data.getString("text_$key", null) ?: ""
    fun number(key: String, fallback: Int) = (data.all[key] as? Number)?.toInt() ?: fallback

    val signedIn = data.getBoolean("signed_in", false)
    val premium = data.getBoolean("premium", false)
    // yesterday's values: today is still to fill in
    val today = SimpleDateFormat("yyyy-MM-dd", Locale.US).format(Date())
    val fresh = data.getString("day", "") == today
    val done = fresh && data.getBoolean("done", false)
    val savedGoal = number("goal_percent", -1)
    val goal = if (savedGoal < 0) -1 else if (fresh) savedGoal.coerceIn(0, 100) else 0

    val link =
        when {
          !signedIn -> "cmficonnect://open"
          !premium -> "cmficonnect://premium"
          else -> "cmficonnect://today"
        }
    views.setOnClickPendingIntent(
        R.id.widget_root,
        HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse(link)))

    views.setTextViewText(R.id.title, text("title"))
    if (!signedIn || !premium) {
      showDove(views, R.drawable.widget_dove_joy)
      views.setTextViewText(R.id.status, text(if (signedIn) "locked" else "signed_out"))
      if (wide) {
        views.setViewVisibility(R.id.items, View.GONE)
        views.setViewVisibility(R.id.open, View.GONE)
      }
      return views
    }

    views.setTextViewText(R.id.status, text(if (done) "done" else "todo"))
    if (goal < 0) {
      showDove(views, if (done) R.drawable.widget_dove_celebrate else R.drawable.widget_dove_cheer)
    } else {
      views.setViewVisibility(R.id.dove, View.GONE)
      views.setViewVisibility(R.id.ring, if (goal >= 100) View.GONE else View.VISIBLE)
      views.setViewVisibility(R.id.ring_full, if (goal >= 100) View.VISIBLE else View.GONE)
      views.setProgressBar(R.id.ring, 100, goal, false)
      views.setViewVisibility(R.id.percent, View.VISIBLE)
      views.setTextViewText(R.id.percent, "$goal %")
    }
    if (wide) {
      views.setViewVisibility(R.id.items, if (fresh) View.VISIBLE else View.GONE)
      views.setTextViewText(R.id.items, text("items"))
      views.setViewVisibility(R.id.open, if (done) View.GONE else View.VISIBLE)
      views.setTextViewText(R.id.open, text("open"))
    }
    return views
  }

  private fun showDove(views: RemoteViews, drawable: Int) {
    views.setViewVisibility(R.id.ring, View.GONE)
    views.setViewVisibility(R.id.ring_full, View.GONE)
    views.setViewVisibility(R.id.percent, View.GONE)
    views.setViewVisibility(R.id.dove, View.VISIBLE)
    views.setImageViewResource(R.id.dove, drawable)
  }
}

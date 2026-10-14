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
import org.json.JSONObject

/**
 * The "Verset du jour" widget: the verse of the day of the app, in its
 * language. The app saves the verses of the next two weeks
 * (lib/src/core/services/home_widgets.dart, VerseWidgetData); at midnight
 * (HomeWidget.scheduleWidgetUpdates) the widget shows the next one. Free,
 * signed in or not.
 */
class VerseWidgetProvider : HomeWidgetProvider() {

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

  // resized: more or fewer lines of the verse
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
    val views = RemoteViews(context.packageName, R.layout.verse_widget)
    val wide = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH) >= 250
    val height = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT)

    views.setOnClickPendingIntent(
        R.id.widget_root,
        HomeWidgetLaunchIntent.getActivity(
            context, MainActivity::class.java, Uri.parse("cmficonnect://verse")))
    views.setTextViewText(
        R.id.title,
        data.getString("verse_title", null) ?: context.getString(R.string.verse_widget_title))

    val today = SimpleDateFormat("yyyy-MM-dd", Locale.US).format(Date())
    val verse =
        runCatching { JSONObject(data.getString("verse_days", null) ?: "{}").optJSONObject(today) }
            .getOrNull()
    if (verse == null) {
      // just installed, or not opened for two weeks
      views.setTextViewText(R.id.verse, context.getString(R.string.verse_widget_empty))
      views.setViewVisibility(R.id.reference, View.GONE)
      return views
    }

    views.setTextViewText(R.id.verse, verse.optString("text"))
    views.setInt(
        R.id.verse,
        "setMaxLines",
        when {
          height >= 220 -> 9
          height >= 160 -> 6
          height >= 110 -> 4
          else -> 2
        })
    val source = data.getString("verse_source", null).orEmpty()
    val reference = verse.optString("ref")
    views.setViewVisibility(R.id.reference, View.VISIBLE)
    views.setTextViewText(
        R.id.reference, if (wide && source.isNotEmpty()) "$reference · $source" else reference)
    return views
  }
}

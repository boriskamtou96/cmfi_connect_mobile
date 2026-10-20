/// "12:34", "1:02:05": the time of a stopwatch.
String stopwatchClock(Duration elapsed) {
  final seconds = elapsed.inSeconds;
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = (seconds % 60).toString().padLeft(2, '0');
  return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$s' : '$m:$s';
}

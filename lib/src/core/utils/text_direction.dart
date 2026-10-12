import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

/// The direction of a text someone typed (an event, a news item): French
/// stays left to right in the Arabic app, Arabic right to left in the others.
TextDirection contentDirection(String text) =>
    intl.Bidi.detectRtlDirectionality(text)
    ? TextDirection.rtl
    : TextDirection.ltr;

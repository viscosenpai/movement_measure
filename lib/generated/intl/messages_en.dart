// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutMenuTitle":
            MessageLookupByLibrary.simpleMessage("About MovementMeasure"),
        "add": MessageLookupByLibrary.simpleMessage("add"),
        "appShareText": MessageLookupByLibrary.simpleMessage(
            "Movement Measure\nCreate your own record of your movement."),
        "comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "commentValidMessage":
            MessageLookupByLibrary.simpleMessage("Please enter a comment."),
        "detail": MessageLookupByLibrary.simpleMessage("Detail"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "howToUse": MessageLookupByLibrary.simpleMessage("How to use"),
        "howToUseBody1": MessageLookupByLibrary.simpleMessage(
            "This is a simple lifelog application that only measures time and distance traveled."),
        "howToUseBody2": MessageLookupByLibrary.simpleMessage(
            "You can record events that occur during the journey with comments."),
        "howToUseBody3": MessageLookupByLibrary.simpleMessage(
            "You can look back on your daily journey like a diary."),
        "howToUseTitle1":
            MessageLookupByLibrary.simpleMessage("Let\'s record your journey."),
        "howToUseTitle2":
            MessageLookupByLibrary.simpleMessage("Let\'s leave some memories."),
        "howToUseTitle3": MessageLookupByLibrary.simpleMessage(
            "Let\'s look back on our daily journey."),
        "measureValidMessage": MessageLookupByLibrary.simpleMessage(
            "You can only add comments during the measurement."),
        "review": MessageLookupByLibrary.simpleMessage("Review"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "showLocationDescriptionBody": MessageLookupByLibrary.simpleMessage(
            "Movement Measure collects location data to enable measurement of distance traveled even when the app is closed or not in use.\n\nTo allow location data in the background, select \"OK\" and then set \"Allow while using App\" in the Location Acquisition Permission dialog."),
        "showLocationDescriptionTitle": MessageLookupByLibrary.simpleMessage(
            "Confirmation of location data"),
        "updaterButtonLabel":
            MessageLookupByLibrary.simpleMessage("Update now"),
        "updaterContent": MessageLookupByLibrary.simpleMessage(
            "A new version of the app is available. Please get the updated version from the store and use it."),
        "updaterTitle":
            MessageLookupByLibrary.simpleMessage("Version Update Information"),
        "version": MessageLookupByLibrary.simpleMessage("Version")
      };
}

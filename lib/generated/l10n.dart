// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Confirmation of location data`
  String get showLocationDescriptionTitle {
    return Intl.message(
      'Confirmation of location data',
      name: 'showLocationDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Movement Measure collects location data to enable measurement of distance traveled even when the app is closed or not in use.\n\nTo allow location data in the background, select "OK" and then set "Allow while using App" in the Location Acquisition Permission dialog.`
  String get showLocationDescriptionBody {
    return Intl.message(
      'Movement Measure collects location data to enable measurement of distance traveled even when the app is closed or not in use.\n\nTo allow location data in the background, select "OK" and then set "Allow while using App" in the Location Acquisition Permission dialog.',
      name: 'showLocationDescriptionBody',
      desc: '',
      args: [],
    );
  }

  /// `Version Update Information`
  String get updaterTitle {
    return Intl.message(
      'Version Update Information',
      name: 'updaterTitle',
      desc: '',
      args: [],
    );
  }

  /// `A new version of the app is available. Please get the updated version from the store and use it.`
  String get updaterContent {
    return Intl.message(
      'A new version of the app is available. Please get the updated version from the store and use it.',
      name: 'updaterContent',
      desc: '',
      args: [],
    );
  }

  /// `Update now`
  String get updaterButtonLabel {
    return Intl.message(
      'Update now',
      name: 'updaterButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a comment.`
  String get commentValidMessage {
    return Intl.message(
      'Please enter a comment.',
      name: 'commentValidMessage',
      desc: '',
      args: [],
    );
  }

  /// `You can only add comments during the measurement.`
  String get measureValidMessage {
    return Intl.message(
      'You can only add comments during the measurement.',
      name: 'measureValidMessage',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Movement Measure\nCreate your own record of your movement.`
  String get appShareText {
    return Intl.message(
      'Movement Measure\nCreate your own record of your movement.',
      name: 'appShareText',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `About MovementMeasure`
  String get aboutMenuTitle {
    return Intl.message(
      'About MovementMeasure',
      name: 'aboutMenuTitle',
      desc: '',
      args: [],
    );
  }

  /// `How to use`
  String get howToUse {
    return Intl.message(
      'How to use',
      name: 'howToUse',
      desc: '',
      args: [],
    );
  }

  /// `Let's record your journey.`
  String get howToUseTitle1 {
    return Intl.message(
      'Let\'s record your journey.',
      name: 'howToUseTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Let's leave some memories.`
  String get howToUseTitle2 {
    return Intl.message(
      'Let\'s leave some memories.',
      name: 'howToUseTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Let's look back on our daily journey.`
  String get howToUseTitle3 {
    return Intl.message(
      'Let\'s look back on our daily journey.',
      name: 'howToUseTitle3',
      desc: '',
      args: [],
    );
  }

  /// `This is a simple lifelog application that only measures time and distance traveled.`
  String get howToUseBody1 {
    return Intl.message(
      'This is a simple lifelog application that only measures time and distance traveled.',
      name: 'howToUseBody1',
      desc: '',
      args: [],
    );
  }

  /// `You can record events that occur during the journey with comments.`
  String get howToUseBody2 {
    return Intl.message(
      'You can record events that occur during the journey with comments.',
      name: 'howToUseBody2',
      desc: '',
      args: [],
    );
  }

  /// `You can look back on your daily journey like a diary.`
  String get howToUseBody3 {
    return Intl.message(
      'You can look back on your daily journey like a diary.',
      name: 'howToUseBody3',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

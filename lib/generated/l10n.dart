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

  /// `first name`
  String get firstName {
    return Intl.message(
      'first name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `seconed name`
  String get seconedName {
    return Intl.message(
      'seconed name',
      name: 'seconedName',
      desc: '',
      args: [],
    );
  }

  /// `home View`
  String get homeView {
    return Intl.message(
      'home View',
      name: 'homeView',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login Loading`
  String get loginLoading {
    return Intl.message(
      'Login Loading',
      name: 'loginLoading',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgetPasswoerd {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPasswoerd',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct email`
  String get pleaseEnterCorrectEmail {
    return Intl.message(
      'Please enter correct email',
      name: 'pleaseEnterCorrectEmail',
      desc: '',
      args: [],
    );
  }

  /// `What is your email?`
  String get whatIsYourEmail {
    return Intl.message(
      'What is your email?',
      name: 'whatIsYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `What is your name?`
  String get whatIsYourName {
    return Intl.message(
      'What is your name?',
      name: 'whatIsYourName',
      desc: '',
      args: [],
    );
  }

  /// `What Is Your Birth Of Date`
  String get whatIsYourBirthOfDate {
    return Intl.message(
      'What Is Your Birth Of Date',
      name: 'whatIsYourBirthOfDate',
      desc: '',
      args: [],
    );
  }

  /// `Birth Of Date`
  String get BirthOfDate {
    return Intl.message(
      'Birth Of Date',
      name: 'BirthOfDate',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `what Is Your Type`
  String get whatIsYourType {
    return Intl.message(
      'what Is Your Type',
      name: 'whatIsYourType',
      desc: '',
      args: [],
    );
  }

  /// `male`
  String get male {
    return Intl.message(
      'male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `female`
  String get female {
    return Intl.message(
      'female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct phone`
  String get pleaseEnterCorrectPhone {
    return Intl.message(
      'Please enter correct phone',
      name: 'pleaseEnterCorrectPhone',
      desc: '',
      args: [],
    );
  }

  /// `What is your Phone?`
  String get whatIsYourPhone {
    return Intl.message(
      'What is your Phone?',
      name: 'whatIsYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get phone {
    return Intl.message(
      'phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Password Validation`
  String get passwordValidation {
    return Intl.message(
      'Password Validation',
      name: 'passwordValidation',
      desc: '',
      args: [],
    );
  }

  /// `PasswordConfirmatiomFieldRequired`
  String get PasswordConfirmatiomFieldRequired {
    return Intl.message(
      'PasswordConfirmatiomFieldRequired',
      name: 'PasswordConfirmatiomFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `passwordNotTheSame`
  String get passwordNotTheSame {
    return Intl.message(
      'passwordNotTheSame',
      name: 'passwordNotTheSame',
      desc: '',
      args: [],
    );
  }

  /// `createPassword`
  String get createPassword {
    return Intl.message(
      'createPassword',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `passwordConfirmation`
  String get passwordConfirmation {
    return Intl.message(
      'passwordConfirmation',
      name: 'passwordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Welcom in Damma`
  String get welcomInDamma {
    return Intl.message(
      'Welcom in Damma',
      name: 'welcomInDamma',
      desc: '',
      args: [],
    );
  }

  /// `Social Media App`
  String get socialMediaApp {
    return Intl.message(
      'Social Media App',
      name: 'socialMediaApp',
      desc: '',
      args: [],
    );
  }

  /// `Lets Start !`
  String get letsStart {
    return Intl.message(
      'Lets Start !',
      name: 'letsStart',
      desc: '',
      args: [],
    );
  }

  /// `Create Account To Know Info`
  String get createAccountToKnowInfo {
    return Intl.message(
      'Create Account To Know Info',
      name: 'createAccountToKnowInfo',
      desc: '',
      args: [],
    );
  }

  /// `What Do You Think?`
  String get whatDoYouThink {
    return Intl.message(
      'What Do You Think?',
      name: 'whatDoYouThink',
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
      Locale.fromSubtags(languageCode: 'ar'),
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

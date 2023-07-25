import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String uri = "https://transfer-dayo-niyi.onrender.com";
const defaultAppColor = Color(0xFF000000);
var amountFormatter = NumberFormat.decimalPattern('en_US');
const String notEmptyError = "This field cannot be empty.";
const String fieldNotValidError = "This field is not valid.";

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

var platformDispatcher = PlatformDispatcher.instance;
var screenHeight = platformDispatcher.views.first.physicalSize.height /
    platformDispatcher.views.first.devicePixelRatio;
var screenWidth = platformDispatcher.views.first.physicalSize.width /
    platformDispatcher.views.first.devicePixelRatio;
var isTablet = (platformDispatcher.views.first.physicalSize.width /
        platformDispatcher.views.first.devicePixelRatio) >
    600;

/*This is the default screen width that is used to obtain the values below
=>428

This is the default screen height that is used to obtain the values below
=>926

These are dynamic width values that change if the screen width changes
This is very important for adapting to screen sizes*/

//This is mostly used for width value and font sizes
//428
final value3 = screenWidth / 142.66;
final value5 = screenWidth / 85.6;
final value10 = screenWidth / 42.8;
final value11 = screenWidth / 38.90;
final value12 = screenWidth / 35.66;
final value14 = screenWidth / 30.57;
final value15 = screenWidth / 28.5;
final value16 = screenWidth / 26.75;
final value18 = screenWidth / 23.77;
final value20 = screenWidth / 21.4;
final value24 = screenWidth / 17.83;
final value25 = screenWidth / 17.12;
final value30 = screenWidth / 14.26;
final value35 = screenWidth / 12.22;
final value40 = screenWidth / 10.7;
final value45 = screenWidth / 9.51;
final value50 = screenWidth / 8.56;
final value55 = screenWidth / 7.78;
final value48 = screenWidth / 8.91;
final value60 = screenWidth / 7.13;
final value65 = screenWidth / 6.58;
final value70 = screenWidth / 6.11;
final value80 = screenWidth / 5.35;
final value90 = screenWidth / 4.755;
final value100 = screenWidth / 4.28;
final value110 = screenWidth / 3.89;
final value130 = screenWidth / 3.29;
final value145 = screenWidth / 2.95;
final value165 = screenWidth / 2.59;
final value200 = screenWidth / 2.14;
final value220 = screenWidth / 1.94;

//This is mostly used for height values
//926
final heightValue3 = screenHeight / 308.666;
final heightValue5 = screenHeight / 185.2;
final heightValue10 = screenHeight / 92.6;
final heightValue13 = screenHeight / 71.23;
final heightValue15 = screenHeight / 61.73;
final heightValue17 = screenHeight / 54.47;
final heightValue18 = screenHeight / 51.44;
final heightValue19 = screenHeight / 48.73;
final heightValue20 = screenHeight / 46.3;
final heightValue21 = screenHeight / 44.09;
final heightValue22 = screenHeight / 42.09;
final heightValue23 = screenHeight / 40.26;
final heightValue24 = screenHeight / 38.58;
final heightValue25 = screenHeight / 37.04;
final heightValue27 = screenHeight / 34.29;
final heightValue28 = screenHeight / 33.07;
final heightValue30 = screenHeight / 30.86;
final heightValue32 = screenHeight / 28.93;
final heightValue33 = screenHeight / 28.06;
final heightValue35 = screenHeight / 26.45;
final heightValue36 = screenHeight / 25.72;
final heightValue37 = screenHeight / 25.02;
final heightValue38 = screenHeight / 24.36;
final heightValue40 = screenHeight / 23.15;
final heightValue43 = screenHeight / 21.53;
final heightValue45 = screenHeight / 20.57;
final heightValue50 = screenHeight / 18.52;
final heightValue55 = screenHeight / 16.83;
final heightValue60 = screenHeight / 15.43;
final heightValue65 = screenHeight / 14.24;
final heightValue67 = screenHeight / 13.82;
final heightValue70 = screenHeight / 13.22;
final heightValue75 = screenHeight / 12.34;
final heightValue80 = screenHeight / 11.575;
final heightValue90 = screenHeight / 10.28;
final heightValue93 = screenHeight / 9.95;
final heightValue95 = screenHeight / 9.74;
final heightValue98 = screenHeight / 9.44;
final heightValue100 = screenHeight / 9.26;
final heightValue110 = screenHeight / 8.41;
final heightValue120 = screenHeight / 7.71;
final heightValue130 = screenHeight / 7.12;
final heightValue140 = screenHeight / 6.61;
final heightValue150 = screenHeight / 6.17;
final heightValue160 = screenHeight / 5.78;
final heightValue165 = screenHeight / 5.61;
final heightValue180 = screenHeight / 5.14;
final heightValue200 = screenHeight / 4.63;
final heightValue220 = screenHeight / 4.20;
final heightValue224 = screenHeight / 4.13;
final heightValue225 = screenHeight / 4.11;
final heightValue228 = screenHeight / 4.06;
final heightValue230 = screenHeight / 4.03;
final heightValue240 = screenHeight / 3.85;
final heightValue250 = screenHeight / 3.704;
final heightValue255 = screenHeight / 3.63;
final heightValue260 = screenHeight / 3.56;
final heightValue270 = screenHeight / 3.42;
final heightValue275 = screenHeight / 3.36;
final heightValue280 = screenHeight / 3.30;

final textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(screenWidth / 52.97),
  ),
  borderSide: const BorderSide(
    color: Colors.transparent,
  ),
);

final textFieldBorderEnabled = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(screenWidth / 52.97),
  ),
  borderSide: const BorderSide(
    color: Colors.transparent,
  ),
);

final textFieldBorderFocused = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(screenWidth / 52.97),
  ),
  borderSide: const BorderSide(
    color: defaultAppColor,
    width: 1.0,
  ),
);

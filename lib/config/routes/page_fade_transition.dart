// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class PageFadeTransition extends PageRouteBuilder {
  @override
  final Widget Function(BuildContext, Animation<double>, Animation<double>)
      pageBuilder;
  @override
  final RouteSettings settings;

  PageFadeTransition({required this.pageBuilder, required this.settings})
      : super(
          pageBuilder: pageBuilder,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          settings: settings,
        );
}

// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';

class PageSlideTransition extends PageRouteBuilder {
  @override
  final Widget Function(BuildContext, Animation<double>, Animation<double>)
      pageBuilder;
  @override
  final RouteSettings settings;

  PageSlideTransition({required this.pageBuilder, required this.settings})
      : super(
          pageBuilder: pageBuilder,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (_, animation, __, child) => SlideTransition(
            position: Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          ),
          settings: settings,
        );
}

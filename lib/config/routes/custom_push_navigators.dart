import 'package:flutter/material.dart';

void namedNav(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}

void popNav(BuildContext context) {
  Navigator.pop(context);
}

void namedNavRemoveUntil(BuildContext context, String route) {
  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
}

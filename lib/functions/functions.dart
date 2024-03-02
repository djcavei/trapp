import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int appNameComparator(Application a, Application b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase());

getErrorBackground(BuildContext ctx) {
  return MaterialStatePropertyAll(Theme.of(ctx).colorScheme.error);
}

getErrorForeground(BuildContext ctx) {
  return MaterialStatePropertyAll(Theme.of(ctx).colorScheme.onError);
}
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void showSnackBar(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

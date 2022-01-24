import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/sites/settings_page.dart';
import 'package:tictactoe/sites/spiele_page.dart';

void main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const SpielePage(),
      routes: <String, WidgetBuilder>{
        SpielePage.route: (context) => const SpielePage(),
        SettingsPage.route: (context) => const SettingsPage(),
      },
    );
  }
}

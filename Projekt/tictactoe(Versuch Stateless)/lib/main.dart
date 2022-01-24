import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/helper/change_provider.dart';
import 'package:tictactoe/sites/settings_page.dart';
import 'package:tictactoe/sites/spiele_page.dart';

void main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(ChangeNotifierProvider(
    create: (_) => ChangeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider(
        create: (_) => ChangeProvider(),
        child: Consumer<ChangeProvider>(
          builder: (context, changeProvider, child) => SpielePage(
            context: context,
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        SpielePage.route: (context) => SpielePage(
              context: context,
            ),
        SettingsPage.route: (context) => const SettingsPage(),
      },
    );
  }
}

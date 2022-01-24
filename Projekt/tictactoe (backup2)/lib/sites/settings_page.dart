import 'package:flutter/material.dart';
import 'package:tictactoe/Widgets/drawer.dart';
import 'package:tictactoe/layout/theme_data.dart';

class SettingsPage extends StatelessWidget {
  static const String route = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return themed(
        context,
        Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          drawer: buildDrawer(context, route),
          body: const Center(
            child: Text("Test"),
          ),
        ));
  }
}

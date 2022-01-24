import 'package:flutter/material.dart';
import 'package:tictactoe/layout/theme_data.dart';
import 'package:tictactoe/sites/settings_page.dart';
import 'package:tictactoe/sites/spiele_page.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: Container(
      color: Colors.lightBlue[50],
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 48,
          ),
          ListTile(
            leading: const Icon(Icons.gamepad),
            title: Text(
              "Spiel",
              //textScaleFactor: getTextScaleByWidth(context),
              style: drawerTextStyle(),
            ),
            selected: currentRoute == SpielePage.route,
            onTap: () =>
                Navigator.pushReplacementNamed(context, SpielePage.route),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              "Settings",
              //textScaleFactor: getTextScaleByWidth(context),
              style: drawerTextStyle(),
            ),
            selected: currentRoute == SettingsPage.route,
            onTap: () =>
                Navigator.pushReplacementNamed(context, SettingsPage.route),
          )
        ],
      ),
    ),
  );
}

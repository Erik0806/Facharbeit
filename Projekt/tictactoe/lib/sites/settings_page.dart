import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/Widgets/drawer.dart';
import 'package:tictactoe/layout/theme_data.dart';

class SettingsPage extends StatefulWidget {
  static const String route = '/settings';
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color pickerColor = Colors.white;
  String nameX = "Spieler X";
  String nameO = "Spieler O";

  @override
  void initState() {
    getColor();
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerX = TextEditingController();
    TextEditingController controllerO = TextEditingController();

    return themed(
        context,
        Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          drawer: buildDrawer(context, SettingsPage.route),
          body: Container(
            color: pickerColor,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Spieler X: ",
                            style: drawerTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              controller: controllerX,
                              autofillHints: const [AutofillHints.username],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "akt: $nameX",
                              ),
                              onEditingComplete: () =>
                                  saveNames("X", controllerX.text),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                saveNames("X", "Spieler X");
                              },
                              child: const Icon(Icons.replay)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Spieler O: ",
                            style: drawerTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              controller: controllerO,
                              autofillHints: const [AutofillHints.username],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "akt: $nameO",
                              ),
                              onEditingComplete: () =>
                                  saveNames("O", controllerO.text),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                saveNames("O", "Spieler O");
                              },
                              child: const Icon(Icons.replay)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Hintergrundfarbe: ",
                            style: drawerTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => pickColor(context),
                              child: const Text(
                                "Hintergrundfarbe wählen",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                changeColor(Colors.white);
                                saveColor(pickerColor);
                              },
                              child: const Icon(Icons.replay)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  getColor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('pickerColor')) {
      setState(() {
        pickerColor = Color(
            sharedPreferences.getInt('pickerColor') ?? Colors.white.value);
      });
    } else {
      sharedPreferences.setInt('pickerColor', Colors.white.value);
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: buildColorPicker(),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                saveColor(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  Widget buildColorPicker() =>
      ColorPicker(pickerColor: pickerColor, onColorChanged: changeColor);

  void saveColor(Color color) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('pickerColor', color.value);
  }

  void saveNames(String key, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, name);
    setState(() {
      if (key == "X") {
        nameX = name;
      } else {
        nameO = name;
      }
    });
  }

  getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey("X")) {
      sharedPreferences.setString("X", "Spieler X");
    }
    if (!sharedPreferences.containsKey("O")) {
      sharedPreferences.setString("O", "Spieler O");
    }
    nameX = sharedPreferences.getString("X") ?? "Spieler X";
    nameO = sharedPreferences.getString("O") ?? "Spieler O";
  }
}

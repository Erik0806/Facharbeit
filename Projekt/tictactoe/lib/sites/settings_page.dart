import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/Widgets/drawer.dart';
import 'package:tictactoe/helper/sharedPreferences.dart' as sHelper;
import 'package:tictactoe/layout/theme_data.dart';

class SettingsPage extends StatefulWidget {
  static const String route = '/settings';
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color backgroundColour = Colors.white;
  String nameX = "Spieler X";
  String nameO = "Spieler O";

  @override
  void initState() {
    getColour();
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
            color: backgroundColour,
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
                  //const Divider(),
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
                  const Divider(
                    endIndent: 50,
                    indent: 50,
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
                              onPressed: () => pickColour(context),
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
                                changeColour(Colors.white);
                                saveColour(backgroundColour);
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

  ///Ruft die gespeicherte HintergrundFarbe ab
  getColour() async {
    var colour = await sHelper.getColour();
    setState(() {
      backgroundColour = colour;
    });
  }

  ///Ändert die Hintergrundfarbe
  void changeColour(Color color) {
    setState(() => backgroundColour = color);
  }

  ///Zeigt den Dialog zum Ändern der Farbe an
  ///Leicht abgeänderte Version von https://pub.dev/packages/flutter_colorpicker
  void pickColour(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: buildColourPicker(),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                saveColour(backgroundColour);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

  Widget buildColourPicker() =>
      ColorPicker(pickerColor: backgroundColour, onColorChanged: changeColour);

  void saveColour(Color color) {
    sHelper.saveBackgroundColour(color);
  }

  void saveNames(String key, String name) async {
    sHelper.saveNames(key, name);
    setState(
      () {
        if (key == "X") {
          nameX = name;
        } else {
          nameO = name;
        }
      },
    );
  }

  getName() async {
    nameX = await sHelper.getNameX();
    nameO = await sHelper.getNameO();
  }
}

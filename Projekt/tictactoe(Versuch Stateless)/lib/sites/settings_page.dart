import 'package:flutter/material.dart';
import 'package:tictactoe/Widgets/drawer.dart';
import 'package:tictactoe/layout/theme_data.dart';

class SettingsPage extends StatelessWidget {
  static const String route = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color pickerColor = Color(0xff443a49);
    Color currentColor = Color(0xff443a49);

    return themed(
        context,
        Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          drawer: buildDrawer(context, route),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text("Spieler X: "),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Name Spieler X",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text("Spieler O: "),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Name Spieler O",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text("Hintergrundfarbe: "),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding:
                    //         EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    //     child: ElevatedButton(
                    //       onPressed: onPressed,
                    //       child: Text("Hintergrundfarbe wählen"),
                    //     ),
                    //   ),
                    //),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

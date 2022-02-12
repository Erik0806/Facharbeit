import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/Widgets/drawer.dart';
import 'package:tictactoe/Widgets/tile.dart';
import 'package:tictactoe/helper/change_provider.dart';
import 'package:tictactoe/helper/player.dart';
import 'package:tictactoe/layout/theme_data.dart';

import '../Widgets/spielstandsanzeige.dart';

class SpielePage extends StatefulWidget {
  static const String route = '/spiel';

  const SpielePage({
    Key? key,
  }) : super(key: key);

  @override
  _SpielePageState createState() => _SpielePageState();
}

///Die Seite die Aufgerufen wird wenn die App gestartet wird. [title] ist der Text der oben in der AppBar steht.
///[_player] ein Objekt des Typs Player um den aktuellen und letzten Spieler bestimmen zu können. [_changeProvider]
///um nach einem Zug das Interfaze zu aktualisieren. [_fields] ist eine zweidimensionale Repräsentation des Spielfeldes.
///[color] beschreibt die Hintergrundfarbe der Seite. [_won] ob das  Spiel gewonnen wurde. [_ignoring] ob man mit den einzelnen Tiles interagieren kann und [_lost] ob
///das Spiel verloren wurde, sprich das gesamte Spielfeld ohne eine vorherigen Sieg voll ist.
class _SpielePageState extends State<SpielePage> {
  final ChangeProvider _changeProvider = ChangeProvider();
  final Player _player = Player(currentPlayer: "X", lastPlayer: "O");
  late List<List<String>> _fields;
  bool _won = false;
  bool _ignoring = false;
  bool _lost = false;
  String _nameX = "Spieler X";
  String _nameO = "Spieler O";

  Color pickerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return themed(
      context,
      Scaffold(
          appBar: AppBar(title: const Text("TicTacToe")),
          drawer: buildDrawer(context, SpielePage.route),
          body: _layouthelper(context, _player)),
    );
  }

  ///Ruft die Methode zum Daten abrufen auf und sorgt dafür, dass die Methode onChange bei einer Spielfeldänderung
  ///aufgerufen wird
  @override
  void initState() {
    super.initState();
    setEmptyFields();
    _changeProvider.addListener(onChange);
    getValues();
  }

  ///Erstellt das Layout der Spieleseite, wo sowohl der Text als auch das Spielfeld angezeigt werden
  ///sorgt dafür, dass sich das Layout an die Fenstergröße anpasst
  Widget _layouthelper(BuildContext context, Player player) {
    Widget testerd = spielfeld(context, player);
    return SafeArea(
      child: Container(
        color: pickerColor,
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return Row(
              children: [
                Flexible(child: testerd),
                Column(
                  children: [
                    const Spacer(),
                    SpielstandsAnzeige(
                        player: player,
                        nameX: _nameX,
                        nameO: _nameO,
                        won: _won,
                        lost: _lost,
                        context: context),
                    const Spacer(),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                SpielstandsAnzeige(
                    player: player,
                    nameX: _nameX,
                    nameO: _nameO,
                    won: _won,
                    lost: _lost,
                    context: context),
                const Spacer(),
                Expanded(
                  flex: 100,
                  child:
                      Align(alignment: Alignment.bottomCenter, child: testerd),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  ///erzeugt das Spielfeld
  Widget spielfeld(BuildContext context, Player player) {
    return GridView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: 9,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        int x = determinexy(index)[0];
        int y = determinexy(index)[1];

        return IgnorePointer(
          ignoring: _ignoring,
          child: Tile(
            player: player,
            x: x,
            y: y,
            changeProvider: _changeProvider,
          ),
        );
      },
    );
  }

  /// Quelle: https://github.com/JohannesMilke/tic_tac_toe_example/blob/master/lib/main.dart
  /// Erstellt eine zweidimensionaleListe mit 3*3 Feldern als Repräsentation des Spielfeldes
  void setEmptyFields() => setState(() => _fields = List.generate(
        3,
        (_) => List.generate(3, (_) => ""),
      ));

  ///Diese Methode wird jedesmal aufgerufen, wenn ein Spielzug gemacht wird
  void onChange() {
    _fields[_changeProvider.x][_changeProvider.y] = _player.lastPlayer;

    if (isWinner(_changeProvider.x, _changeProvider.y)) {
      setState(() {
        pickerColor = Colors.green;
        _ignoring = true;
        _won = true;
      });
    } else if (isEnd()) {
      setState(() {
        pickerColor = Colors.red.shade600;
        _ignoring = true;
        _lost = true;
      });
    } else {
      //Die Seite muss einmal neu gebaut werden, damit die Spielstandsanzeige aktualisiert wird
      setState(() {});
    }
  }

  /// Quelle: https://github.com/JohannesMilke/tic_tac_toe_example/blob/master/lib/main.dart
  /// Prüft ob das Spielfeld voll ist;
  bool isEnd() =>
      _fields.every((values) => values.every((value) => value != ""));

  /// Quelle: https://stackoverflow.com/a/1058804
  /// Prüft ob eine Siegbedingung vorliegt
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = _fields[x][y];
    const n = 3;

    for (int i = 0; i < n; i++) {
      if (_fields[x][i] == player) col++;
      if (_fields[i][y] == player) row++;
      if (_fields[i][i] == player) diag++;
      if (_fields[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  ///Baut die Rückgabe des Itembuilders (1-9) in passende x und y werte einer zweidimensionalen Liste mit 3*3 Feldern um
  List<int> determinexy(int index) {
    int x;
    int y;
    switch (index) {
      case 0:
        x = 0;
        y = 0;
        break;
      case 1:
        x = 1;
        y = 0;
        break;
      case 2:
        x = 2;
        y = 0;
        break;
      case 3:
        x = 0;
        y = 1;
        break;
      case 4:
        x = 1;
        y = 1;
        break;
      case 5:
        x = 2;
        y = 1;
        break;
      case 6:
        x = 0;
        y = 2;
        break;
      case 7:
        x = 1;
        y = 2;
        break;
      case 8:
        x = 2;
        y = 2;
        break;
      default:
        x = 0;
        y = 0;
    }
    List<int> values = [x, y];
    return values;
  }

  /// Lädt die gespeicherten Daten, also die Namen und die Hintergrundfarbe aus dem Speicher und trägt diese in diese in die
  /// dafür vorgesehenen Variablen ein.
  getValues() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('pickerColor')) {
      setState(() {
        pickerColor = Color(
            sharedPreferences.getInt('pickerColor') ?? Colors.white.value);
      });
    } else {
      sharedPreferences.setInt('pickerColor', Colors.white.value);
    }
    if (sharedPreferences.containsKey('X')) {
      setState(() {
        _nameX = sharedPreferences.getString("X") ?? "Spieler X";
      });
    } else {
      sharedPreferences.setString('X', "Spieler X");
    }
    if (sharedPreferences.containsKey('O')) {
      setState(() {
        _nameO = sharedPreferences.getString("O") ?? "Spieler O";
      });
    } else {
      sharedPreferences.setString('O', "Spieler O");
    }
  }
}

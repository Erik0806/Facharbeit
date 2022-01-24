import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/Widgets/drawer.dart';
import 'package:tictactoe/Widgets/tile.dart';
import 'package:tictactoe/helper/change_provider.dart';
import 'package:tictactoe/helper/player.dart';
import 'package:tictactoe/layout/theme_data.dart';

class SpielePage extends StatefulWidget {
  static const String route = '/spiel';

  const SpielePage({
    Key? key,
  }) : super(key: key);

  @override
  _SpielePageState createState() => _SpielePageState();
}

///Die Seite die Aufgerufen wird wenn die App gestartet wird. [title] ist der Text der oben in der AppBar steht.
///[player] ein Objekt des Typs Player um den aktuellen und letzten Spieler bestimmen zu können. [changeProvider]
///um nach einem Zug das Interfaze zu aktualisieren. [fields] ist eine zweidimensionale Repräsentation des Spielfeldes.
///[color] beschreibt die Hintergrundfarbe der Seite. [won] ob das  Spiel gewonnen wurde. [cPlayer] beschreibt den
///aktuellen Spieler in Form eines Strings. [ignoring] ob man mit den einzelnen Tiles interagieren kann und [lost] ob
///das Spiel verloren wurde, sprich das gesamte Spielfeld ohne eine vorherigen Sieg voll ist.
class _SpielePageState extends State<SpielePage> {
  String title = "TicTacToe";
  ChangeProvider changeProvider = ChangeProvider();
  Player player = Player(currentPlayer: "X", lastPlayer: "O");
  late List<List<String>> fields;
  bool won = false;
  String cPlayer = "X";
  bool ignoring = false;
  bool lost = false;
  String nameX = "Spieler X";
  String nameO = "Spieler O";

  Color pickerColor = Colors.white;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
    changeProvider.addListener(onChange);
    getValues();
  }

  @override
  Widget build(BuildContext context) {
    return themed(
      context,
      Scaffold(
          appBar: AppBar(title: Text(title)),
          drawer: buildDrawer(context, SpielePage.route),
          body: _layouthelper(context, player)),
    );
  }

  /// Quelle: https://github.com/JohannesMilke/tic_tac_toe_example/blob/master/lib/main.dart
  /// Erstellt eine zweidimensionaleListe mit 3*3 Feldern als Repräsentation des Spielfeldes
  void setEmptyFields() => setState(() => fields = List.generate(
        3,
        (_) => List.generate(3, (_) => ""),
      ));

  ///Diese Methode wird jedesmal aufgerufen, wenn ein Spielzug gemacht wird
  void onChange() {
    fields[changeProvider.x][changeProvider.y] = player.lastPlayer;

    setState(() {
      cPlayer = player.currentPlayer;
    });

    if (isWinner(changeProvider.x, changeProvider.y)) {
      setState(() {
        ignoring = true;
        pickerColor = Colors.green;
        won = true;
      });
    } else if (isEnd()) {
      setState(() {
        pickerColor = Colors.red.shade600;
        ignoring = true;
        lost = true;
      });
    }
  }

  /// Quelle: https://github.com/JohannesMilke/tic_tac_toe_example/blob/master/lib/main.dart
  /// Prüft ob das Spielfeld voll ist;
  bool isEnd() =>
      fields.every((values) => values.every((value) => value != ""));

  /// Quelle: https://stackoverflow.com/a/1058804
  /// Prüft ob eine Siegbedingung vorliegt
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = fields[x][y];
    const n = 3;

    for (int i = 0; i < n; i++) {
      if (fields[x][i] == player) col++;
      if (fields[i][y] == player) row++;
      if (fields[i][i] == player) diag++;
      if (fields[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
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
                Expanded(child: playeranzeige()),
              ],
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                playeranzeige(),
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

  ///Textanzeige über oder rechts neben dem Spielfeld, während des Spiels zeigt es den aktuellen Spieler an
  ///danach den Sieger
  Widget playeranzeige() {
    String lPlayer = player.lastPlayer == "X" ? nameX : nameO;
    String currentPlayer = player.currentPlayer == "X" ? nameX : nameO;

    return Center(
      child: Text(
        won
            ? "$lPlayer hat gewonnen"
            : lost
                ? "Unentschieden!"
                : "$currentPlayer ist am Zug",
        style: playerAnzeigeStyle(),
        textAlign: TextAlign.center,
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
          ignoring: ignoring,
          child: Tile(
            player: player,
            x: x,
            y: y,
            changeProvider: changeProvider,
          ),
        );
      },
    );
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
        nameX = sharedPreferences.getString("X") ?? "Spieler X";
      });
    } else {
      sharedPreferences.setString('X', "Spieler X");
    }
    if (sharedPreferences.containsKey('O')) {
      setState(() {
        nameO = sharedPreferences.getString("O") ?? "Spieler O";
      });
    } else {
      sharedPreferences.setString('O', "Spieler O");
    }
  }
}

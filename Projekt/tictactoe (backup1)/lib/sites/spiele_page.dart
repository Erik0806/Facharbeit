import 'dart:io';

import 'package:flutter/material.dart';
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

class _SpielePageState extends State<SpielePage> {
  String title = "TicTacToe";
  Player player = Player(currentPlayer: "X", lastPlayer: "O");
  ChangeProvider changeProvider = ChangeProvider();
  late List<List<String>> fields;
  Color color = Colors.white;
  bool won = false;

  @override
  void initState() {
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {}

    super.initState();
    changeProvider.addListener(onChange);
    setEmptyFields();
  }

  void setEmptyFields() => setState(() => fields = List.generate(
        3,
        (_) => List.generate(3, (_) => ""),
      ));

  @override
  Widget build(BuildContext context) {
    return themed(
      context,
      Scaffold(
          appBar: AppBar(title: Text(title)),
          drawer: buildDrawer(context, SpielePage.route),
          body: won ? const Text("Won") : _spiel(context, player)),
    );
  }

  Widget _spiel(BuildContext context, Player player) {
    return SafeArea(
      child: Container(
        color: color,
        child: Center(
          child: Row(
            children: [
              Column(
                children: [
                  Tile(
                    x: 0,
                    y: 0,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                  Tile(
                    x: 0,
                    y: 1,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                  Tile(
                    x: 0,
                    y: 2,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                ],
              ),
              Column(
                children: [
                  Tile(
                    x: 1,
                    y: 0,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                  Tile(
                    x: 1,
                    y: 1,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                  Tile(
                    x: 1,
                    y: 2,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                ],
              ),
              Column(
                children: [
                  Tile(
                    x: 2,
                    y: 0,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                  Tile(
                    x: 2,
                    y: 1,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                  Tile(
                    x: 2,
                    y: 2,
                    player: player,
                    changeProvider: changeProvider,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChange() {
    fields[changeProvider.x][changeProvider.y] = player.lastPlayer;

    if (isWinner(changeProvider.x, changeProvider.y)) {
      setState(() {
        color = Colors.green;
        won = true;
      });
    }
  }

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
}

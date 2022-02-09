import 'package:flutter/material.dart';

import '../helper/player.dart';
import '../layout/theme_data.dart';
import '../sites/spiele_page.dart';

class spielstandsanzeige extends StatelessWidget {
  const spielstandsanzeige({
    Key? key,
    required this.player,
    required this.nameX,
    required this.nameO,
    required this.won,
    required this.lost,
    required this.context,
  }) : super(key: key);

  final Player player;
  final String nameX;
  final String nameO;
  final bool won;
  final bool lost;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    String lPlayer = player.lastPlayer == "X" ? nameX : nameO;
    String currentPlayer = player.currentPlayer == "X" ? nameX : nameO;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              won
                  ? "$lPlayer hat gewonnen"
                  : lost
                      ? "Unentschieden!"
                      : "$currentPlayer ist am Zug",
              style: playerAnzeigeStyle(40),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 140,
            child: Visibility(
              visible: won || lost,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(SpielePage.route),
                child: Text(
                  "Restart",
                  style: playerAnzeigeStyle(30),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

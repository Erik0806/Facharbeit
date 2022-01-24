import 'package:flutter/material.dart';
import 'package:tictactoe/helper/change_provider.dart';
import 'package:tictactoe/helper/player.dart';
import 'package:tictactoe/layout/theme_data.dart';

class Tile extends StatefulWidget {
  const Tile({
    Key? key,
    required this.player,
    required this.changeProvider,
    required this.x,
    required this.y,
  }) : super(key: key);
  final Player player;
  final int x;
  final int y;
  final ChangeProvider changeProvider;
  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> with AutomaticKeepAliveClientMixin {
  String text = "";
  bool ignoring = false;
  Color buttonColour = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return IgnorePointer(
      ignoring: ignoring,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: buttonColour,
          ),
          onPressed: pressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 60),
            textScaleFactor: getTextScalebyWithAndHeigth(context),
          ),
        ),
      ),
    );
  }

  double getSize(BuildContext context) {
    return MediaQuery.of(context).size.width - 48 >
            MediaQuery.of(context).size.height - 104
        ? MediaQuery.of(context).size.height - 104
        : MediaQuery.of(context).size.width - 48;
  }

  pressed() {
    setState(() {
      ignoring = true;
      String player = widget.player.currentPlayer;
      text = player;
      if (player == "X") {
        widget.player.currentPlayer = "O";
        widget.player.lastPlayer = "X";
        buttonColour = const Color(0xFFB0BEC5);
        //Colors.blueGrey
      } else {
        widget.player.currentPlayer = "X";
        widget.player.lastPlayer = "O";
        buttonColour = const Color(0xFF37474F);
      }
    });
    widget.changeProvider.changed(widget.x, widget.y);
  }

  changeColour(Color color) {
    setState(() {
      buttonColour = color;
    });
  }

  @override
  bool get wantKeepAlive => true;
}

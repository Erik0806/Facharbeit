import 'package:flutter/material.dart';
import 'package:tictactoe/helper/player.dart';

class ChangeProvider extends ChangeNotifier {
  int _x = 0;
  int _y = 0;

  int get getX => _x;
  int get getY => _y;

  void changed(int pX, int pY) {
    _x = pX;
    _y = pY;
    notifyListeners();
  }
}

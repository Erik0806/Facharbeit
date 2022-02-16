import 'package:flutter/material.dart';

class ChangeProvider extends ChangeNotifier {
  //Die Variablen um zubestimmen, welches Tile als letzes angeklickt wurde
  int _x = 0;
  int _y = 0;

  int get x => _x;
  int get y => _y;

  ///aktualisiert [_x] und [_y] mit [pX] und [pY] und ruft danach alle Listeners auf
  void changed(int pX, int pY) {
    _x = pX;
    _y = pY;
    notifyListeners();
  }
}

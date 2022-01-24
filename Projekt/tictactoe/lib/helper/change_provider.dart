import 'package:flutter/material.dart';

class ChangeProvider extends ChangeNotifier {
  int _x = 0;
  int _y = 0;

  int get x => _x;
  int get y => _y;

  void changed(int pX, int pY) {
    _x = pX;
    _y = pY;
    notifyListeners();
  }
}

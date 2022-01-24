import 'package:flutter/material.dart';

class ChangeProvider extends ChangeNotifier {
  late int x;
  late int y;

  void changed(int pX, int pY) {
    x = pX;
    y = pY;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Holt die Hintergrundfarbe aus dem persistenten Speicher
Future<Color> getColour() async {
  Color colour = Colors.white;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.containsKey('backgroundColour')) {
    colour = Color(
        sharedPreferences.getInt('backgroundColour') ?? Colors.white.value);
  } else {
    sharedPreferences.setInt('backgroundColour', Colors.white.value);
  }
  return colour;
}

///Speichert die Hintegrundfarbe persistent ab
void saveBackgroundColour(Color color) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt('backgroundColour', color.value);
}

///Speichert den gegebenen Namen persistent ab
void saveNames(String key, String name) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, name);
}

///Holt den Namen für Spieler X aus dem persistenten Speicher
Future<String> getNameX() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey("X")) {
    sharedPreferences.setString("X", "Spieler X");
  }
  return sharedPreferences.getString("X") ?? "Spieler X";
}

///Holt den Namen für Spieler O aus dem persistenten Speicher
Future<String> getNameO() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (!sharedPreferences.containsKey("O")) {
    sharedPreferences.setString("O", "Spieler O");
  }
  return sharedPreferences.getString("O") ?? "Spieler O";
}

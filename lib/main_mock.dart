import 'package:flutter/material.dart';
import 'app.dart';
import './services/config.dart';
void main() {
  Config.env=Env.MOCK;
  runApp(App());
}
 

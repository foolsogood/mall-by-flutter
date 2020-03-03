import 'package:flutter/material.dart';
import 'app.dart';
import './services/config.dart';
void main() {
  Config.env=Env.LOCAL;
  runApp(App());
}
 

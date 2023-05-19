import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/';
import 'package:firebase_database_web/firebase_database_web.dart';
import 'package:recipe_food/src/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
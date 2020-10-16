import 'package:flutter/material.dart';
import './android/AndroidApp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(AndroidApp());
}

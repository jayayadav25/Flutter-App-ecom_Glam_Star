import 'package:flutter/material.dart';
import 'src/bootstrap.dart';
import 'src/app/app.dart';

Future<void> main() async {
  await bootstrap(const App());
}


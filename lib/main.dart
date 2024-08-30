import "package:flutter/material.dart";
import "package:flash_cards/core/database.dart";
import "app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDb();

  runApp(App());
}

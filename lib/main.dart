import "package:flutter/material.dart";
import "package:flash_cards/core/database.dart";
import 'package:flash_cards/views/subjects/subject_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDb();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(),
        body: const SubjectView(),
      ),
    );
  }
}

import "package:flash_cards/modules/subjects/subjects.dart";
import "package:flutter/material.dart";
import "package:flash_cards/core/database.dart";

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
        body: const SubjectsPage(),
      ),
    );
  }
}

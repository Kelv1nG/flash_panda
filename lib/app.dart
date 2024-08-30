import "package:flash_cards/modules/subjects/subjects.dart";
import "package:flash_cards/repositories/subject_repository/subject_repository.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class App extends StatelessWidget {
  App({super.key});

  final SubjectRepositoryRemote subjectRepositoryRemote =
      SubjectRepositoryRemote();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: subjectRepositoryRemote,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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

import "package:flash_cards/modules/subjects/subjects.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubjectsBloc>(
      create: (BuildContext context) =>
          SubjectsBloc()..add(const SubjectRetrieveListEvent()),
      child: const SubjectsView(),
    );
  }
}

class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: const AddSubjectButton(),
      body: BlocBuilder<SubjectsBloc, SubjectsState>(
        builder: (context, subjectsState) {
          return ListView.builder(
            itemCount: subjectsState.subjects.length,
            itemBuilder: (context, index) {
              final subject = subjectsState.subjects[index];
              return SubjectCard(subject: subject);
            },
          );
        },
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flash_cards/modules/subjects/subjects.dart";

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
      body: BlocListener<SubjectsBloc, SubjectsState>(
        listenWhen: (previous, current) =>
            previous.subjectList != current.subjectList &&
            current.action != null,
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);
          messenger.showSnackBar(_notificationBar(state));
        },
        child: BlocBuilder<SubjectsBloc, SubjectsState>(
          builder: (context, subjectsState) {
            return ListView.builder(
              itemCount: subjectsState.subjectList.length,
              itemBuilder: (context, index) {
                final subject = subjectsState.subjectList[index];
                return SubjectCard(subject: subject);
              },
            );
          },
        ),
      ),
    );
  }

  SnackBar _notificationBar(SubjectsState state) {
    final subjectName = state.subject?.name ?? '';
    final actionTaken = state.action?.name;
    final displayText = "Subject $subjectName $actionTaken";
    final snackBar = SnackBar(
      content: Text(displayText, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.pink,
      duration: const Duration(seconds: 1),
    );
    return snackBar;
  }
}

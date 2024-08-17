import "package:flutter/material.dart";
import "package:flash_cards/models/subject.dart";
import "./components/add_subject_button.dart";

class SubjectView extends StatefulWidget {
  const SubjectView({super.key});

  @override
  SubjectViewState createState() => SubjectViewState();
}

class SubjectViewState extends State<SubjectView> {
  List<Subject> subjects = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: const AddSubjectButton(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flash_cards/repositories/subject_repository/subject_repository.dart';
import './subject_form.dart';

class SubjectFormDialog extends StatelessWidget {
  const SubjectFormDialog(
      {super.key, required this.title, this.subject, required this.onSubmit});

  final String title;
  final Subject? subject;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: SizedBox(
        width: 300,
        height: 200,
        child: SubjectFormPage(subject: subject, onSubmit: onSubmit),
      ),
    );
  }
}

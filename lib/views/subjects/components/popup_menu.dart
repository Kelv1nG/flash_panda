import 'package:flash_cards/views/subjects/components/subject_form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flash_cards/models/subject.dart';
import 'package:flash_cards/utils/form_enum.dart';
import 'package:flash_cards/repository/subject.dart';

class SubjectPopUpMenu extends StatelessWidget {
  const SubjectPopUpMenu({
    super.key,
    required this.subject,
    required this.callback,
  });

  final Function callback;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            value: "Edit",
            child: const Text("Edit"),
            onTap: () {
              displaySubjectFormDialog(context, "Edit Subject",
                  formAction: FormEnum.update,
                  subject: subject,
                  callback: callback);
            }),
        PopupMenuItem<String>(
            value: "Delete",
            child: const Text("Delete"),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showDeleteConfirmationDialog(context);
              });
            }),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Subject"),
          content: const Text("Are you sure you want to delete this subject?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await deleteSubject(subject.id!);
                await callback(); // this looks shit pero sige lang muna
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}

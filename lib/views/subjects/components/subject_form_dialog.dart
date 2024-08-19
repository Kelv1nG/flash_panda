import "package:flutter/material.dart";
import "package:flash_cards/models/subject.dart";
import "./subject_form.dart";
import "package:flash_cards/utils/form_enum.dart";

Future<void> displaySubjectFormDialog(BuildContext context, String formTitle,
    {required FormEnum formAction, Function? callback, Subject? subject}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(formTitle)),
        content: SizedBox(
          width: 300, // Set the desired width
          height: 200, // Set the desired height
          child: SubjectForm(
              formAction: formAction, subject: subject, callback: callback),
        ),
      );
    },
  );
}

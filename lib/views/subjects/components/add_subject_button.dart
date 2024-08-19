import "package:flutter/material.dart";
import "./subject_form_dialog.dart";
import "package:flash_cards/utils/form_enum.dart";

class AddSubjectButton extends StatelessWidget {
  const AddSubjectButton({super.key, this.callback});

  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Add Subject'),
      onPressed: () {
        displaySubjectFormDialog(context, "Add Subject",
            formAction: FormEnum.create, callback: callback);
      },
      icon: const Icon(Icons.add),
      foregroundColor: Colors.white,
      backgroundColor: Colors.pink,
    );
  }
}

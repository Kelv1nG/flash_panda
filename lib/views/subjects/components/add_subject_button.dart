import "package:flutter/material.dart";
import "./add_subject_form.dart";

class AddSubjectButton extends StatelessWidget {
  const AddSubjectButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Add Subject'),
      onPressed: () {
        addSubjectForm(context);
      },
      icon: const Icon(Icons.add),
      foregroundColor: Colors.white,
      backgroundColor: Colors.pink,
    );
  }

  Future<void> addSubjectForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Center(child: Text('Add Subject')),
          content: SizedBox(
            width: 300, // Set the desired width
            height: 200, // Set the desired height
            child: AddSubjectForm(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_cards/modules/subjects/bloc/subjects_bloc.dart';
import './subject_form_dialog.dart';

class AddSubjectButton extends StatelessWidget {
  const AddSubjectButton({super.key});

  static const String label = 'Add Subject';

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text(label),
      onPressed: () async {
        _onPressed(context);
      },
      icon: const Icon(Icons.add),
      foregroundColor: Colors.white,
      backgroundColor: Colors.pink,
    );
  }

  void _onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SubjectsBloc>(),
          child: SubjectFormDialog(
            title: label,
            onSubmit: (name) {
              context.read<SubjectsBloc>().add(SubjectAddedEvent(name));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}

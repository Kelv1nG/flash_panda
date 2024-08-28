import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_cards/modules/subjects/bloc/subjects_bloc.dart';
import 'package:flash_cards/repositories/subject/subject.dart';
import './subject_form_dialog.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(subject.name),
        trailing: _PopupMenuButton(subject: subject),
        onTap: () {
          // TODO: add navigation to categories here
        },
      ),
    );
  }
}

class _PopupMenuButton extends StatelessWidget {
  const _PopupMenuButton({required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "Edit",
          child: const Text("Edit"),
          onTap: () => _onTapEdit(context),
        ),
        PopupMenuItem<String>(
          value: "Delete",
          child: const Text("Delete"),
          onTap: () => _onTapDelete(context),
        ),
      ],
    );
  }

  void _onTapEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SubjectsBloc>(),
          child: SubjectFormDialog(
            title: "Edit Subject",
            subject: subject,
            onSubmit: (name) {
              context
                  .read<SubjectsBloc>()
                  .add(SubjectUpdatedEvent(subject.id!, name));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _onTapDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<SubjectsBloc>(),
          child: AlertDialog(
            title: const Text("Delete Subject"),
            content:
                const Text("Are you sure you want to delete this subject?"),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  context
                      .read<SubjectsBloc>()
                      .add(SubjectDeletedEvent(subject.id!));
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

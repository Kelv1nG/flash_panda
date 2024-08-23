import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_cards/modules/subjects/bloc/subjects_bloc.dart';
import 'package:flash_cards/models/subject.dart';
import './subject_form_dialog.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(subject.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PopupMenuButton(subject: subject),
            ],
          ),
        ),
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
          onTap: () {
            _onTapEdit(context);
          },
          child: const Text("Edit"),
        ),
        const PopupMenuItem<String>(
          value: "Delete",
          child: Text("Delete"),
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
            },
          ),
        );
      },
    );
  }
}

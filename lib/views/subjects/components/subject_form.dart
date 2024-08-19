import 'package:flutter/material.dart';
import 'package:flash_cards/repository/subject.dart';
import 'package:flash_cards/models/subject.dart';
import 'package:flash_cards/utils/form_enum.dart';

class SubjectForm extends StatefulWidget {
  const SubjectForm(
      {super.key, required this.formAction, this.subject, this.callback});

  final FormEnum formAction;
  final Subject? subject;
  final Function? callback;

  @override
  SubjectFormState createState() => SubjectFormState();
}

class SubjectFormState extends State<SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _subjectTextController;

  @override
  void initState() {
    super.initState();
    _subjectTextController = TextEditingController(
      text: widget.subject?.name ?? '',
    );
  }

  Future<void> _onSave() async {
    String subjectName = _subjectTextController.text;

    switch (widget.formAction) {
      case FormEnum.create:
        {
          Subject subject = Subject(name: subjectName);
          await addSubject(subject);
        }
      case FormEnum.update:
        {
          final Subject subject =
              Subject(id: widget.subject!.id, name: subjectName);
          await updateSubject(subject);
        }
    }
    await widget.callback
        ?.call(); // holy shit this deep how would i know if function is coroutine or not, crazy
    await _showSnackBarAndClose(subjectName);
  }

  Future<void> _showSnackBarAndClose(String subjectName) async {
    final action = widget.formAction == FormEnum.create ? "added" : "updated";
    final displayText = "Subject $subjectName $action";

    Navigator.of(context).pop();
    final snackBar = SnackBar(
      content: Text(displayText, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.pink,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Card(
              child: TextFormField(
                controller: _subjectTextController,
                autofocus: true,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  await _onSave();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pink,
                ),
                child: const Text("Save"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

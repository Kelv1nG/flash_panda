import 'package:flutter/material.dart';
import 'package:flash_cards/repositories/subject_repository/subject_repository.dart';

class SubjectFormPage extends StatelessWidget {
  SubjectFormPage({super.key, this.subject, required this.onSubmit})
      : _controller = TextEditingController(text: subject?.name);

  final Subject? subject;
  final Function onSubmit;
  final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

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
              child: TextFormField(autofocus: true, controller: _controller),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  onSubmit(_controller.text);
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

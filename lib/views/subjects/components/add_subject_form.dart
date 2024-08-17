import 'package:flutter/material.dart';

class AddSubjectForm extends StatefulWidget {
  const AddSubjectForm({super.key});

  @override
  AddSubjectFormState createState() => AddSubjectFormState();
}

class AddSubjectFormState extends State<AddSubjectForm> {
  final _formKey = GlobalKey<FormState>();
  final _subjectTextController = TextEditingController();

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
                onPressed: () {},
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

import "package:flutter/material.dart";
import "package:flash_cards/models/subject.dart";
import "package:flash_cards/repository/subject.dart";
import "./components/add_subject_button.dart";
import "./components/popup_menu.dart";

class SubjectView extends StatefulWidget {
  const SubjectView({super.key});

  @override
  SubjectViewState createState() => SubjectViewState();
}

class SubjectViewState extends State<SubjectView> {
  late List<Subject> subjects;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  Future<void> _fetchSubjects() async {
    isLoading = true;

    subjects = await listSubjects();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Subjects'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: AddSubjectButton(callback: _fetchSubjects),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(subject.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SubjectPopUpMenu(
                              subject: subject, callback: _fetchSubjects),
                        ],
                      ),
                    ),
                  );
                }));
  }
}

import 'models/subject.dart';

class SubjectRepositoryInterface {
  Future<List<Subject>> listSubjects() async {
    throw UnimplementedError();
  }

  Future<Subject> getSubject(int subjectId) async {
    throw UnimplementedError();
  }

  Future<Subject> addSubject(Subject subject) async {
    throw UnimplementedError();
  }

  Future<Subject> updateSubject(Subject subject) async {
    throw UnimplementedError();
  }

  Future<void> deleteSubject(int subjectId) async {
    throw UnimplementedError();
  }
}

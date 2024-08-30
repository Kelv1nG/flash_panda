import 'schema/subject.dart';

class SubjectRepositoryInterface {
  Future<List<Subject>> listSubjects() async {
    throw UnimplementedError();
  }

  Future<Subject> getSubject(int subjectId) async {
    throw UnimplementedError();
  }

  Future<Subject> createSubject(SubjectCreateDTO data) async {
    throw UnimplementedError();
  }

  Future<Subject> updateSubject(int subjectId, SubjectUpdateDTO data) async {
    throw UnimplementedError();
  }

  Future<void> deleteSubject(int subjectId) async {
    throw UnimplementedError();
  }
}

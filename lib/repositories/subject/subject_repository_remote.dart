import 'dart:convert';

import 'package:http/http.dart' as http;
import 'subject_repository_interface.dart';
import 'models/subject.dart';
import 'exceptions.dart';

const baseUrl = "10.0.2.2:8000";

class SubjectRepositoryRemote implements SubjectRepositoryInterface {
  SubjectRepositoryRemote(http.Client? httpClient)
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  @override
  Future<List<Subject>> listSubjects() async {
    final uri = Uri.http(baseUrl, "/subjects");
    final res = await _httpClient.get(uri);

    if (res.statusCode != 200) {
      throw SubjectRequestFailed();
    }
    final List<dynamic> data = jsonDecode(res.body);
    final List<Subject> subjects =
        data.map((item) => Subject.fromJson(item)).toList();
    return subjects;
  }

  @override
  Future<Subject> getSubject(int subjectId) async {
    final uri = Uri.http(baseUrl, "/subjects/$subjectId");
    final res = await _httpClient.get(uri);

    if (res.statusCode != 200) {
      throw SubjectRequestFailed();
    }
    final data = jsonDecode(res.body);
    return Subject.fromJson(data);
  }

  @override
  Future<Subject> addSubject(Subject subject) async {
    final uri = Uri.http(baseUrl, "/subjects");
    final res = await _httpClient.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        subject.toJson(),
      ),
    );

    if (res.statusCode != 201) {
      throw SubjectAddFailed();
    }
    return Subject.fromJson(jsonDecode(res.body));
  }

  @override
  Future<Subject> updateSubject(Subject subject) async {
    final uri = Uri.http(baseUrl, "/subjects/${subject.id}");
    final res = await _httpClient.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subject.toJson()),
    );
    if (res.statusCode != 200) {
      throw SubjectUpdateFailed();
    }
    return Subject.fromJson(jsonDecode(res.body));
  }

  @override
  Future<void> deleteSubject(int subjectId) async {
    final uri = Uri.http(baseUrl, "/subjects/$subjectId");
    final res = await _httpClient.delete(uri);

    if (res.statusCode != 204) {
      throw SubjectDeleteFailed();
    }
  }
}

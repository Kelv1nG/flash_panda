import 'dart:convert';

import 'package:flash_cards/repositories/subject_repository/subject_repository.dart';
import 'package:http/http.dart' as http;

const baseUrl = "10.0.2.2:8000";

String generateRequestFailedMessage(int statusCode) {
  return "Failed with status code: $statusCode";
}

class SubjectRepositoryRemote implements SubjectRepositoryInterface {
  SubjectRepositoryRemote({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  @override
  Future<List<Subject>> listSubjects() async {
    final uri = Uri.http(baseUrl, "/subjects");
    final res = await _httpClient.get(uri);

    if (res.statusCode != 200) {
      throw SubjectRequestFailed(generateRequestFailedMessage(res.statusCode));
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

    if (res.statusCode == 404) {
      throw SubjectNotFound();
    }

    if (res.statusCode != 200) {
      throw SubjectRequestFailed(generateRequestFailedMessage(res.statusCode));
    }

    final data = jsonDecode(res.body);
    return Subject.fromJson(data);
  }

  @override
  Future<Subject> createSubject(SubjectCreateDTO data) async {
    final uri = Uri.http(baseUrl, "/subjects");
    final res = await _httpClient.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        data.toJson(),
      ),
    );

    if (res.statusCode != 201) {
      throw SubjectAddFailed(generateRequestFailedMessage(res.statusCode));
    }

    return Subject.fromJson(jsonDecode(res.body));
  }

  @override
  Future<Subject> updateSubject(int subjectId, SubjectUpdateDTO data) async {
    final uri = Uri.http(baseUrl, "/subjects/$subjectId");
    final res = await _httpClient.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );
    if (res.statusCode == 404) {
      throw SubjectNotFound();
    }

    if (res.statusCode != 200) {
      throw SubjectUpdateFailed(generateRequestFailedMessage(res.statusCode));
    }

    return Subject.fromJson(jsonDecode(res.body));
  }

  @override
  Future<void> deleteSubject(int subjectId) async {
    final uri = Uri.http(baseUrl, "/subjects/$subjectId");
    final res = await _httpClient.delete(uri);

    if (res.statusCode == 404) {
      throw SubjectNotFound();
    }

    if (res.statusCode != 204) {
      throw SubjectDeleteFailed(generateRequestFailedMessage(res.statusCode));
    }
  }
}

import 'package:flash_cards/repositories/subject_repository/subject_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('SubjectRepositoryRemote', () {
    late http.Client httpClient;
    late SubjectRepositoryRemote repo;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      repo = SubjectRepositoryRemote(httpClient: httpClient);
    });

    group('listSubjects', () {
      test('success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn("""
          [
            {
              "id": 1,
              "name": "Math"
            },
            {
              "id": 2,
              "name": "Science"
            }
          ]""");
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual = await repo.listSubjects();
        const expected = [
          Subject(id: 1, name: 'Math'),
          Subject(id: 2, name: 'Science'),
        ];
        expect(actual, expected);
      });

      test('subject request failed', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        await expectLater(
          repo.listSubjects(),
          throwsA(isA<SubjectRequestFailed>()),
        );
      });
    });

    group('getSubject', () {
      test('success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn("""
          {
            "id": 1,
            "name": "Math"
          }
          """);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual = await repo.getSubject(1);
        const expected = Subject(id: 1, name: "Math");
        expect(actual, expected);
      });

      test('fail subject not found', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        await expectLater(
          repo.getSubject(1),
          throwsA(isA<SubjectNotFound>()),
        );
      });

      test('fail request failed', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(403);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        await expectLater(
          repo.getSubject(1),
          throwsA(isA<SubjectRequestFailed>()),
        );
      });
    });

    group('updateSubject', () {
      test('success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn("""
          {
            "id": 1,
            "name": "Science"
          }
          """);
        when(() => httpClient.patch(any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'))).thenAnswer((_) async => response);

        const data = SubjectUpdateDTO("irrelevant data in this test");

        final actual = await repo.updateSubject(1, data);
        const expected = Subject(id: 1, name: "Science");
        expect(actual, expected);
      });

      test('fail subject not found', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.patch(any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'))).thenAnswer((_) async => response);

        const data = SubjectUpdateDTO("irrelevant data in this test");

        await expectLater(
          repo.updateSubject(1, data),
          throwsA(isA<SubjectNotFound>()),
        );
      });

      test('fail request failed', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(403);
        when(() => httpClient.patch(any(),
            body: any(named: 'body'),
            headers: any(named: 'headers'))).thenAnswer((_) async => response);

        const data = SubjectUpdateDTO("irrelevant data in this test");

        await expectLater(
          repo.updateSubject(1, data),
          throwsA(isA<SubjectUpdateFailed>()),
        );
      });
    });
    group('deleteSubject', () {
      test('success', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(204);
        when(() => httpClient.delete(any())).thenAnswer((_) async => response);

        await repo.deleteSubject(1);
        verify(() => httpClient.delete(any())).called(1);
      });

      test('fail subject not found', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.delete(any())).thenAnswer((_) async => response);

        await expectLater(
          repo.deleteSubject(1),
          throwsA(isA<SubjectNotFound>()),
        );
      });

      test('fail request failed', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(403);
        when(() => httpClient.delete(any())).thenAnswer((_) async => response);

        await expectLater(
          repo.deleteSubject(1),
          throwsA(isA<SubjectDeleteFailed>()),
        );
      });
    });
  });
}

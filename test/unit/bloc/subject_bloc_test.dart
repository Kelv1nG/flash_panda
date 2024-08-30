import 'package:bloc_test/bloc_test.dart';
import 'package:flash_cards/modules/subjects/bloc/subjects_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flash_cards/repositories/subject_repository/subject_repository.dart';

class MockSubjectRepository extends Mock
    implements SubjectRepositoryInterface {}

class SubjectCreateDTOFake extends Fake implements SubjectCreateDTO {}

class SubjectUpdateDTOFake extends Fake implements SubjectUpdateDTO {}

void main() {
  late SubjectRepositoryInterface subjectRepository;
  late SubjectsBloc subjectsBloc;

  group('SubjectsBloc', () {
    setUpAll(() {
      registerFallbackValue(SubjectCreateDTOFake());
      registerFallbackValue(SubjectUpdateDTOFake());
    });

    setUp(() {
      subjectRepository = MockSubjectRepository();
      subjectsBloc = SubjectsBloc(subjectRepository);
    });

    tearDown(() {
      subjectsBloc.close();
    });

    test('initial state is correct', () {
      expect(subjectsBloc.state, const SubjectsState());
    });

    blocTest<SubjectsBloc, SubjectsState>(
      'emits [Status.success] when SubjectRetrieveListEvent is added',
      build: () {
        when(() => subjectRepository.listSubjects())
            .thenAnswer((_) async => const [Subject(id: 1, name: 'Math')]);
        return subjectsBloc;
      },
      act: (bloc) => bloc.add(const SubjectRetrieveListEvent()),
      expect: () => const [
        SubjectsState(
          status: Status.success,
          subjectList: [Subject(id: 1, name: 'Math')],
        ),
      ],
    );

    blocTest<SubjectsBloc, SubjectsState>(
      'emits [Status.success] with new subject when SubjectAddedEvent is added',
      build: () {
        when(() => subjectRepository.createSubject(any()))
            .thenAnswer((_) async => const Subject(id: 1, name: 'Physics'));
        when(() => subjectRepository.listSubjects())
            .thenAnswer((_) async => const [Subject(id: 1, name: 'Physics')]);
        return subjectsBloc;
      },
      act: (bloc) =>
          bloc.add(const SubjectCreateEvent(SubjectCreateDTO('Physics'))),
      expect: () => const [
        SubjectsState(
          status: Status.success,
          subjectList: [Subject(id: 1, name: 'Physics')],
          action: Action.created,
          subject: Subject(id: 1, name: 'Physics'),
        ),
      ],
    );

    blocTest<SubjectsBloc, SubjectsState>(
      'emits [Status.success] with new subject when SubjectAddedEvent is added',
      build: () {
        when(() => subjectRepository.createSubject(any()))
            .thenAnswer((_) async => const Subject(id: 1, name: 'Physics'));
        when(() => subjectRepository.listSubjects())
            .thenAnswer((_) async => const [Subject(id: 1, name: 'Physics')]);
        return subjectsBloc;
      },
      act: (bloc) =>
          bloc.add(const SubjectCreateEvent(SubjectCreateDTO('Physics'))),
      expect: () => const [
        SubjectsState(
          status: Status.success,
          subjectList: [Subject(id: 1, name: 'Physics')],
          action: Action.created,
          subject: Subject(id: 1, name: 'Physics'),
        ),
      ],
    );

    blocTest<SubjectsBloc, SubjectsState>(
      'emits [Status.success] with updated subject when SubjectUpdatedEvent is added',
      build: () {
        when(() => subjectRepository.updateSubject(any(), any())).thenAnswer(
            (_) async => const Subject(id: 1, name: 'Advanced Math'));
        when(() => subjectRepository.listSubjects()).thenAnswer(
            (_) async => const [Subject(id: 1, name: 'Advanced Math')]);
        return subjectsBloc;
      },
      act: (bloc) => bloc
          .add(const SubjectUpdatedEvent(1, SubjectUpdateDTO('Advanced Math'))),
      expect: () => const [
        SubjectsState(
          status: Status.success,
          subjectList: [Subject(id: 1, name: 'Advanced Math')],
          action: Action.updated,
          subject: Subject(id: 1, name: 'Advanced Math'),
        ),
      ],
    );

    blocTest<SubjectsBloc, SubjectsState>(
      'emits [Status.success] with updated list when SubjectDeletedEvent is added',
      build: () {
        when(() => subjectRepository.deleteSubject(any()))
            .thenAnswer((_) async {});
        when(() => subjectRepository.listSubjects())
            .thenAnswer((_) async => []);
        return subjectsBloc;
      },
      act: (bloc) => bloc.add(const SubjectDeletedEvent(1)),
      expect: () => const [
        SubjectsState(
          status: Status.success,
          subjectList: [],
          action: Action.deleted,
        ),
      ],
    );
  });
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_cards/repositories/subject_repository/subject_repository.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectEvent, SubjectsState> {
  SubjectsBloc(this.subjectRepository) : super(const SubjectsState()) {
    on<SubjectRetrieveListEvent>(_onSubjectRetrieveListEvent);
    on<SubjectCreateEvent>(_onSubjectAdded);
    on<SubjectUpdatedEvent>(_onSubjectUpdated);
    on<SubjectDeletedEvent>(_onSubjectDeleted);
  }

  final SubjectRepositoryInterface subjectRepository;

  Future<void> _onSubjectRetrieveListEvent(
    SubjectRetrieveListEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    final subjectList = await subjectRepository.listSubjects();
    emit(
      SubjectsState(
        status: Status.success,
        subjectList: subjectList,
      ),
    );
  }

  Future<void> _onSubjectAdded(
    SubjectCreateEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    final subject =
        await subjectRepository.createSubject(event.subjectCreateData);
    final subjectList = await subjectRepository.listSubjects();
    emit(
      SubjectsState(
          status: Status.success,
          subjectList: subjectList,
          action: Action.created,
          subject: subject),
    );
  }

  Future<void> _onSubjectUpdated(
    SubjectUpdatedEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    final subject = await subjectRepository.updateSubject(
        event.subjectId, event.subjectUpdateData);
    final subjectList = await subjectRepository.listSubjects();
    emit(
      SubjectsState(
          status: Status.success,
          subjectList: subjectList,
          action: Action.updated,
          subject: subject),
    );
  }

  Future<void> _onSubjectDeleted(
    SubjectDeletedEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    await subjectRepository.deleteSubject(event.id);

    final subjectList = await subjectRepository.listSubjects();
    emit(
      SubjectsState(
          status: Status.success,
          subjectList: subjectList,
          action: Action.deleted),
    );
  }
}

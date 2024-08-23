import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flash_cards/models/subject.dart';
import 'package:flash_cards/repository/subject.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectEvent, SubjectsState> {
  SubjectsBloc() : super(const SubjectsState()) {
    on<SubjectRetrieveListEvent>(_onSubjectRetrieveListEvent);
    on<SubjectAddedEvent>(_onSubjectAdded);
    on<SubjectUpdatedEvent>(_onSubjectUpdated);
    on<SubjectDeletedEvent>(_onSubjectDeleted);
  }

  Future<void> _onSubjectRetrieveListEvent(
    SubjectRetrieveListEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    final subjects = await listSubjects();
    emit(SubjectsState(status: SubjectsStatus.success, subjects: subjects));
  }

  Future<void> _onSubjectAdded(
    SubjectAddedEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    final subject = Subject(name: event.name);
    await addSubject(subject);

    final subjects = await listSubjects();
    emit(SubjectsState(status: SubjectsStatus.success, subjects: subjects));
  }

  Future<void> _onSubjectUpdated(
    SubjectUpdatedEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    final subject = Subject(id: event.id, name: event.name);
    await updateSubject(subject);

    final subjects = await listSubjects();
    emit(SubjectsState(status: SubjectsStatus.success, subjects: subjects));
  }

  Future<void> _onSubjectDeleted(
    SubjectDeletedEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    await deleteSubject(event.id);

    final subjects = await listSubjects();
    emit(SubjectsState(status: SubjectsStatus.success, subjects: subjects));
  }
}

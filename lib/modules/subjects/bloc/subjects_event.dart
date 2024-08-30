part of 'subjects_bloc.dart';

sealed class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

final class SubjectRetrieveListEvent extends SubjectEvent {
  const SubjectRetrieveListEvent();
}

final class SubjectCreateEvent extends SubjectEvent {
  const SubjectCreateEvent(this.subjectCreateData);

  final SubjectCreateDTO subjectCreateData;

  @override
  List<Object> get props => [subjectCreateData];
}

final class SubjectUpdatedEvent extends SubjectEvent {
  const SubjectUpdatedEvent(this.subjectId, this.subjectUpdateData);

  final int subjectId;
  final SubjectUpdateDTO subjectUpdateData;

  @override
  List<Object> get props => [subjectId, subjectUpdateData];
}

final class SubjectDeletedEvent extends SubjectEvent {
  const SubjectDeletedEvent(this.id);

  final int id;

  @override
  List<int> get props => [id];
}

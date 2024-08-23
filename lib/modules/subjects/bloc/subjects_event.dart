part of 'subjects_bloc.dart';

sealed class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

final class SubjectRetrieveListEvent extends SubjectEvent {
  const SubjectRetrieveListEvent();
}

final class SubjectAddedEvent extends SubjectEvent {
  const SubjectAddedEvent(this.name);

  final String name;

  @override
  List<String> get props => [name];
}

final class SubjectUpdatedEvent extends SubjectEvent {
  const SubjectUpdatedEvent(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}

final class SubjectDeletedEvent extends SubjectEvent {
  const SubjectDeletedEvent(this.id);

  final int id;

  @override
  List<int> get props => [id];
}

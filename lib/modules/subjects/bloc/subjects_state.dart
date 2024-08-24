part of 'subjects_bloc.dart';

enum Status { initial, loading, success, failure }

enum Action { created, updated, deleted }

final class SubjectsState extends Equatable {
  const SubjectsState({
    this.status = Status.initial,
    this.subjectList = const [],
    this.action,
    this.subject,
  });

  final Status status;
  final List<Subject> subjectList;
  final Action? action;
  final Subject? subject;

  SubjectsState copyWith({
    Status? status,
    List<Subject>? subjectList,
    Action? action,
    Subject? subject,
  }) {
    return SubjectsState(
        status: status ?? this.status,
        subjectList: subjectList ?? this.subjectList,
        action: action ?? this.action,
        subject: subject ?? this.subject);
  }

  @override
  List<Object?> get props => [status, subjectList, action, subject];
}

part of 'subjects_bloc.dart';

enum SubjectsStatus { initial, loading, success, failure }

final class SubjectsState extends Equatable {
  const SubjectsState({
    this.status = SubjectsStatus.initial,
    this.subjects = const [],
  });

  final SubjectsStatus status;
  final List<Subject> subjects;

  @override
  List<Object?> get props => [status, subjects];
}

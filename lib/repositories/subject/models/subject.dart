import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject extends Equatable {
  const Subject({this.id, required this.name});

  Subject copyWith({int? id, String? name}) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  final int? id;
  final String name;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);

  @override
  List<Object?> get props => [id, name];
}

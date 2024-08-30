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

  @override
  List<Object?> get props => [id, name];
}

@JsonSerializable()
class SubjectCreateDTO {
  const SubjectCreateDTO(this.name);

  final String name;

  Map<String, dynamic> toJson() => _$SubjectCreateDTOToJson(this);
}

@JsonSerializable()
class SubjectUpdateDTO {
  const SubjectUpdateDTO(this.name);

  final String name;

  Map<String, dynamic> toJson() => _$SubjectUpdateDTOToJson(this);
}

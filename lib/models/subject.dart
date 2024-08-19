import "./category.dart";

class Subject {
  final int? id;
  String name;
  List<Category> categories;

  Subject({this.id, required this.name, this.categories = const []});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }

  static Subject fromMap(Map<String, dynamic> map) {
    return Subject(id: map["id"], name: map["name"]);
  }

  @override
  String toString() {
    return 'Subject{id: $id, name: $name}';
  }
}

class User {
  String? id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = "",
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'birthday': birthday,
    };
  }
}

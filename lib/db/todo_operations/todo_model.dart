class ToDo {
  String id;
  String title;
  String description;
  bool isDone;
  DateTime createdAt;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isDone: json['isDone'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isDone': isDone,
        'createdAt': createdAt.toIso8601String(),
      };
}

class Priority {
  final String id;
  final String name;
  final int quadrant;

  Priority({
    required this.id,
    required this.name,
    required this.quadrant,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    id: json['id'],
    name: json['name'],
    quadrant: json['quadrant'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'quadrant': quadrant,
  };
}

class TodoModel {
  final String id;
  final String title;
  final String details;
  final DateTime time;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.details,
    required this.time,
    required this.isCompleted,
  });

  // Convert TodoModel to a Map to store in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'time': time.toIso8601String(), // Store time as string (ISO 8601 format)
      'iscompleted': isCompleted ? 1 : 0, // Store boolean as integer (1 or 0)
    };
  }

  // Convert a Map to a TodoModel object
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      time: DateTime.parse(map['time']), // Convert string to DateTime
      isCompleted: map['iscompleted'] == 1, // Convert integer to boolean
    );
  }
}

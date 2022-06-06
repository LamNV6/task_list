class Task {
  static const tableName = "Task";
  static const uidColumnName = "uid";
  static const taskIdColumnName = "taskId";
  static const isDoneColumnName = "isDone";
  static const createdDateTimeColumnName = "createdDateTime";
  Task({
    required this.uid,
    required this.taskId,
    this.title,
    this.detail,
    required this.isDone,
    this.createdDateTime,
    this.updatedDateTime,
  });
  String uid;
  String taskId;
  String? title;
  String? detail;
  bool isDone;
  String? createdDateTime;
  String? updatedDateTime;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        uid: json["uid"],
        taskId: json["taskId"],
        title: json["title"],
        detail: json["detail"],
        isDone: json["isDone"],
        createdDateTime: json["createdDateTime"],
        updatedDateTime: json["updatedDateTime"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "taskId": taskId,
        "title": title,
        "detail": detail,
        "isDone": isDone,
        "createdDateTime": createdDateTime,
        "updatedDateTime": updatedDateTime,
      };

  Task copyWith({
    String? uid,
    String? taskId,
    String? title,
    String? detail,
    bool? isDone,
    String? createdDateTime,
    String? updatedDateTime,
  }) {
    return Task(
      uid: uid ?? this.uid,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      isDone: isDone ?? this.isDone,
      createdDateTime: createdDateTime ?? this.createdDateTime,
      updatedDateTime: updatedDateTime ?? this.updatedDateTime,
    );
  }

  Task checked({
    String? uid,
    String? taskId,
    String? title,
    String? detail,
    required bool isDone,
    String? createdDateTime,
    String? updatedDateTime,
  }) {
    return Task(
      uid: uid ?? this.uid,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      isDone: isDone,
      createdDateTime: createdDateTime ?? this.createdDateTime,
      updatedDateTime: updatedDateTime ?? this.updatedDateTime,
    );
  }
}

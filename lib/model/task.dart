class Task {
  Task(
      {this.id = '',
      required this.title,
      required this.desc,
      required this.dateTime,
      this.isDone = false});

  static const String _idKey = 'id';
  static const String _titleKey = 'title';
  static const String _descKey = 'desc';
  static const String _dateKey = 'dateTime';
  static const String _isDoneKey = 'isDone';

  static const String collectionName = 'tasks';

  String id;
  String title;
  String desc;
  DateTime dateTime;
  bool isDone;

  Task.FromFireStore(Map<String, dynamic> json)
      : this(
          id: json[Task._idKey] as String,
          title: json[Task._titleKey] as String,
          desc: json[Task._descKey] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(json[Task._dateKey]),
          isDone: json[Task._isDoneKey] as bool,
        );

  Map<String, dynamic> toFireStore() {
    return {
      Task._idKey: id,
      Task._titleKey: title,
      Task._descKey: desc,
      Task._dateKey: dateTime.millisecondsSinceEpoch,
      Task._isDoneKey: isDone,
    };
  }
}

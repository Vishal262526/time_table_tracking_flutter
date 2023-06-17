class Task {
  final String uid;
  final String subject;
  final String description;
  final String date;
  final String startTime;
  final String endTime;

  Task({
    required this.uid,
    required this.subject,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "subject": subject,
      "description": description,
      "date": date,
      "start_time": startTime,
      "end_time": endTime,
      "completed":false,
    };
  }
}

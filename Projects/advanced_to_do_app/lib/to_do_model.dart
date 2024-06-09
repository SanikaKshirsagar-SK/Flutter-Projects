class ToDoModelClass {
  int? taskId;
  String title;
  String description;
  String date;

  ToDoModelClass(
    {
      this.taskId,
      required this.title,
      required this.description,
      required this.date
    }
  );

  Map<String, dynamic> taskMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }

  @override
  String toString(){
    return 'title: $title, description: $description, date : $date';
  }
}

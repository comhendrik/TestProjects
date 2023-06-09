class Task {
  String id;
  String title;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    this.isDone = false
  });

  static List<Task> getFiveTasks() {
    List<Task> tasks = [
      Task(id: '0', title: 'Waschen'),
      Task(id: '1', title: 'Fugen'),
      Task(id: '2', title: 'Fugen'),
      Task(id: '3', title: 'Fugen'),
      Task(id: '4', title: 'Fugen'),
      Task(id: '5', title: 'Waschen')

    ];
    if (tasks.length >= 5) {
      return tasks.take(5).toList();
    }
    return tasks;
  }

}
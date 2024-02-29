class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, this.isDone = false, this.todoText});

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'check mail', isDone: true),
      ToDo(id: '02', todoText: 'Morning excercise', isDone: true),
      ToDo(id: '03', todoText: 'team meeting'),
      ToDo(id: '04', todoText: 'work on mobile apps for 2 hours'),
      ToDo(id: '05', todoText: 'Dinner with jenny', isDone: true),
      ToDo(id: '06', todoText: 'buy anything'),
    ];
  }
}

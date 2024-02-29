import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem(
      {super.key,
      required this.todoo,
      required this.onToDoChange,
      required this.onDeleteItem});

  final ToDo todoo;
  final onToDoChange;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          onToDoChange(todoo);
        },
        leading: IconButton(
          onPressed: () {
            onToDoChange(todoo);
          },
          icon: Icon(
            todoo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        title: Text(
          todoo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todoo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: tdRed, borderRadius: BorderRadius.circular(8)),
            child: IconButton(
                onPressed: () {
                  onDeleteItem(todoo.id);
                },
                icon: Icon(Icons.delete),
                color: Colors.white,
                iconSize: 18)),
      ),
    );
  }
}

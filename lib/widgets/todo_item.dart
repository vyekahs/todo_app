import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onDeleteItem,
      required this.onToDoChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: toWhite,
          leading: Icon(
            todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
            color: toBlue,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 16,
                color: toBlack,
                decoration: todo.isDone! ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: toRed,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                color: toWhite,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(todo.id);
                },
              )),
        ));
  }
}

import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todoText;
  bool? isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: "1", todoText: "일번이니", isDone: true),
      ToDo(id: "2", todoText: "이번이니", isDone: false),
      ToDo(id: "3", todoText: "삼번이니", isDone: false),
      ToDo(id: "4", todoText: "사번이니", isDone: false),
      ToDo(id: "5", todoText: "오번이니", isDone: false),
      ToDo(id: "6", todoText: "육번이니", isDone: false),
      ToDo(id: "7", todoText: "칠번이니", isDone: false),
      ToDo(id: "8", todoText: "팔번이니", isDone: false),
      ToDo(id: "9", todoText: "구번이니", isDone: false),
      ToDo(id: "10", todoText: "십번이니", isDone: false),
    ];
  }
}

import "package:flutter/material.dart";
import "package:todo_app/constants/colors.dart";
import "../widgets/todo_item.dart";
import "../model/todo.dart";

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDo = todosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todo in _foundToDo)
                        ToDoItem(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: toWhite,
                    boxShadow: const [
                      BoxShadow(
                          color: toGrey,
                          blurRadius: 10.0,
                          offset: Offset(0, 0),
                          spreadRadius: 0)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: "할 일 목록 추가해",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(80, 46), elevation: 10),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((todo) => todo.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
          isDone: false));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((todo) => todo.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: toBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(Icons.menu, color: toBlack, size: 30),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/profile.jpg'),
          ),
        )
      ]),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: toWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: toBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
              color: toGrey,
            ),
          )),
    );
  }
}

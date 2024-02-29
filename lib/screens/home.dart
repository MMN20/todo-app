import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todos = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundTodo = todos;
  }

  @override
  Widget build(BuildContext context) {
    SizedBox size = const SizedBox(
      height: 12,
    );
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                size,
                _searchBox(),
                Expanded(
                  child: ListView(children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      child: const Text(
                        'All ToDos',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (ToDo item in _foundTodo.reversed)
                      ToDoItem(
                        todoo: item,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      )
                  ]),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 10.0,
                            spreadRadius: 0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: _addNewTodoItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  void _addNewTodoItem() {
    if (_todoController.text != '') {
      setState(() {
        todos.add(
            ToDo(id: todos.length.toString(), todoText: _todoController.text));
      });
    }
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {});
    todo.isDone = !todo.isDone;
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todos.removeWhere((item) => item.id == id);
    });
  }

  Container _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: TextField(
        onChanged: (val) {
          _runFilter(val);
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 25, maxWidth: 25),
            border: InputBorder.none),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/avatar.jpg',
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
      backgroundColor: tdBGColor,
    );
  }
}

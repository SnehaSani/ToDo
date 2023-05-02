import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : _buildAppBar(),
      backgroundColor: Colors.green,
      body :  Stack(
        children: [
          Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Text(
                              "All Your Tasks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          for(ToDo todoo in todosList)
                          ToDoItem
                            (todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                        ],
                      ),
                    )
                  ],
                )
          ),
          Align(
            alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.only(bottom : 20,right: 20,left:20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [ BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                      ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _todoController ,
                      decoration: InputDecoration(
                        hintText: 'Add new task...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom:20,right:20),
                    child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        print(1);
                        _addToDoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black54,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                    ),
                  )
                ],
              ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
      print(todosList);
    });

    _todoController.clear();
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff3d3a3a),
      title : Center(
        child: Text('Task Manager',
          style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 20.0,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
          },
        ),
      ],
    );
  }
}


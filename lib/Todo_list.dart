import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];

  void addTodo() {
    TextEditingController todoController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String newTodo = '';
          return AlertDialog(
            icon: const Icon(Icons.calendar_today_outlined),
            title: const Text("Add a new Todo"),
            content: TextField(
              controller: todoController,
              autofocus: true,
              onChanged: (value) {
                newTodo = value;
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (todoController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please fill the todo form before submit")));
                    }else{
                      setState(() {
                        todos.add(Todo(name:newTodo));
                      });
                    }
                  },
                  child: const Text('Add'))
            ],
          );
        });
  }

  void editTodo(int index){
    String todo = '';
    TextEditingController todoController = TextEditingController();
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Edit ${todos[index].name}'),
        content: TextField(
          autofocus: true,
          onChanged: (value){
            todo = value;
          },

        ),
        actions: [
          TextButton(onPressed: (){
            if (todoController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Please fill the todo form before submit")));
            }else{
              setState(() {
                todos[index].name = todo;
              });
            }
          }, child: Text('Edit'))
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ,
    );
  }
}

class Todo {
  String name;
  bool isDone;

  Todo({required this.name,  this.isDone = false});
}

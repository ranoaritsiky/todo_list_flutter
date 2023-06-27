import "package:flutter/material.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Todo {
  String name;
  bool isDone;

  Todo({required this.name, this.isDone = false});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];
  String titleAlertDialog = "Do your really want to do this action";

  void addTodo() {
    TextEditingController todoController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String newTodo = '';
          return AlertDialog(
            title: const Text('Add a new Todo'),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please fill a todo")));
                    } else {
                      setState(() {
                        todos.add(Todo(name: newTodo));
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'))
            ],
          );
        });
  }

  void deleteTodo(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titleAlertDialog),
            content: Text("Are you sure to delete  ${todos[index].name} in the list of Todos?"),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      todos.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }

  void editTodo(int index){
    String todo = todos[index].name;
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Edit a Todo"),
        content: TextField(
          autofocus: true,
          onChanged: (value){
            todo = value;
          },
        ),
        actions: [
          TextButton(onPressed: (){
            setState(() {
              todos[index].name = todo;
            });
            Navigator.of(context).pop();
          }, child: Text("Edit"))
        ],
      );
    });
  }

  String myTitle = "Todo ";
  void changeTitle() {
    setState(() {
      myTitle = "Hello";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () => changeTitle(),
              child: Icon(Icons.account_circle_rounded),
            )),
        backgroundColor: Colors.tealAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        title: Text(
          myTitle,
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(todos[index].name),
              onTap: (){
                editTodo(index);
              },
              trailing: Checkbox(
                value: todos[index].isDone,
                onChanged: (bool? value) {
                  deleteTodo(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/todo_controller.dart';
import 'package:todo_app/src/model/edit_input.dart';
import 'package:todo_app/src/model/todo_data.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';
import 'package:todo_app/src/screens/resources/ListHolder.dart';
import 'package:todo_app/src/screens/resources/dialogs/TodoInput.dart';

class HomeScreen extends StatefulWidget {
  final AuthController auth;
  const HomeScreen(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoController _todoController;
  AuthController get _auth => widget.auth;
  @override
  void initState() {
    _todoController = TodoController(_auth.currentUser!.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        child: Icon(Icons.add),
        onPressed: () async {
          InputHolder? input = await showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return TodoInput();
            },
          );
          if (input != null) {
            if (mounted) {
              setState(() {
                addToDo(input.title, input.details);
              });
            }
          }
        },
      ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            _auth.logout();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.25,
                alignment: Alignment(-0.8, -0.3),
                decoration: BoxDecoration(
                  color: Colors.green[600],
                ),
                width: (MediaQuery.of(context).size.width),
                child: Text(
                  'Welcome ' + _auth.currentUser!.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              ListHolder(_auth, size: size)
            ],
          ),
        ),
      ),
    );
  }

  addToDo(String title, String details) {
    if (mounted) {
      setState(() {
        _todoController.addTodo(TodoData(
          title: title,
          details: details,
        ));
      });
    }
  }
}

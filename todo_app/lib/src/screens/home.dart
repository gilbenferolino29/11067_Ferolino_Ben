// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/src/model/edit_input.dart';
import 'package:todo_app/src/model/todo_data.dart';
import 'package:todo_app/src/screens/resources/ListHolder.dart';
import 'package:todo_app/src/screens/resources/dialogs/TodoInput.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            icon: Icon(Icons.menu),
            onPressed: () {},
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
                    'Welcome Ben',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                ListHolder(size: size)
              ],
            ),
          ),
        ));
  }

  addToDo(String title, String details) {
    int index = 0;
    if (todoContents.isEmpty) {
      index = 0;
    } else {
      index = todoContents.last.id + 1;
    }
    if (mounted) {
      setState(() {
        todoContents.add(TodoData(
          title: title,
          details: details,
          id: index,
        ));
      });
    }
  }
}

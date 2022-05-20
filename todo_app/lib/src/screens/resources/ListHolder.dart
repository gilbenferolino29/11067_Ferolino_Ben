// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/todo_controller.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';

import '../../model/edit_input.dart';
import '../../model/todo_data.dart';
import 'dialogs/EditInput.dart';

class ListHolder extends StatefulWidget {
  final AuthController auth;
  const ListHolder(
    this.auth, {
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ListHolder> createState() => _ListHolderState();
}

class _ListHolderState extends State<ListHolder> {
  late TodoController _todoController;
  AuthController get _auth => widget.auth;

  @override
  void initState() {
    _todoController = TodoController(_auth.currentUser!.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: widget.size.height * 0.74,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: widget.size.height * 0.05),
            SizedBox(
              height: widget.size.height * 0.65,
              child: ListView.builder(

                  //shrinkWrap: true,
                  itemCount: _todoController.data.length,
                  itemBuilder: (context, index) {
                    final todo = _todoController.data[index];
                    if (_todoController.data.isEmpty) {
                      return Container();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Dismissible(
                            key: ObjectKey(todo),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.orange,
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 32),
                            ),
                            secondaryBackground: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.red,
                              child: Icon(Icons.delete,
                                  color: Colors.white, size: 32),
                            ),
                            onDismissed: (direction) async {
                              switch (direction) {
                                case DismissDirection.endToStart:
                                  if (mounted) {
                                    setState(() {
                                      _todoController.removeTodo(todo);
                                    });
                                  }
                                  break;
                                case DismissDirection.startToEnd:
                                  InputHolder input = await showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return EditInput(_auth, todo: todo);
                                    },
                                  );
                                  if (mounted) {
                                    setState(() {});
                                  }
                                  break;
                              }
                            },
                            child: Container(
                              color: Colors.green[400],
                              // decoration: ShapeDecoration(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(20))),
                              //   color: Colors.green[400],
                              // ),
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.title,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(height: 4),
                                  Row(children: [
                                    Flexible(child: Text(todo.details)),
                                  ]),
                                  SizedBox(height: 5),
                                  Text(todo.parsedDate.toString(),
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

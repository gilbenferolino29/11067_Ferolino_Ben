import 'package:flutter/material.dart';
import 'package:todo_app/src/controllers/todo_controller.dart';
import 'package:todo_app/src/model/todo_data.dart';
import 'package:todo_app/src/screens/login/auth_controller.dart';

import '../../../model/edit_input.dart';

class EditInput extends StatefulWidget {
  final AuthController auth;
  final TodoData todo;
  const EditInput(
    this.auth, {
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<EditInput> createState() => _EditInputState();
}

class _EditInputState extends State<EditInput> {
  AuthController get _auth => widget.auth;
  late TodoController _todoController;

  @override
  void initState() {
    _todoController = TodoController(_auth.currentUser!.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _cTitle = TextEditingController();
    final TextEditingController _cDetails = TextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add To Do",
                style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 30),
            const Text("Title"),
            TextFormField(
              //initialValue: title,
              controller: _cTitle,
            ),
            SizedBox(height: 10),
            const Text("Details"),
            TextFormField(
              //initialValue: details,
              maxLines: 5,
              controller: _cDetails,
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 75),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Add todo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop(_todoController.updateTodo(
                      widget.todo, _cTitle.text, _cDetails.text));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

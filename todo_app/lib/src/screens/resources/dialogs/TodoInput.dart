import 'package:flutter/material.dart';

import '../../../model/edit_input.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({Key? key}) : super(key: key);

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _cTitle = TextEditingController();
  final TextEditingController _cDetails = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              controller: _cTitle,
            ),
            SizedBox(height: 10),
            const Text("Details"),
            TextFormField(
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
                  if (_cTitle.text == "" || _cDetails.text == "") {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context)
                        .pop(InputHolder(_cTitle.text, _cDetails.text));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

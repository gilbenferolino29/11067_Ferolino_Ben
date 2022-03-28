// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../model/edit_input.dart';
import '../../model/todo_data.dart';
import 'dialogs/EditInput.dart';

class ListHolder extends StatefulWidget {
  const ListHolder({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ListHolder> createState() => _ListHolderState();
}

class _ListHolderState extends State<ListHolder> {
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
                  itemCount: todoContents.length,
                  itemBuilder: (context, index) {
                    final todo = todoContents[index];
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
                            child:
                                Icon(Icons.edit, color: Colors.white, size: 32),
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
                                setState(() {
                                  todoContents.removeAt(index);
                                });
                                break;
                              case DismissDirection.startToEnd:
                                InputHolder input = await showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return EditInput(
                                      title: todoContents[index].title,
                                      details: todoContents[index].details,
                                    );
                                  },
                                );
                                setState(() {
                                  todoContents.removeAt(index);
                                  EditToDo(input.title, input.details, index);
                                });
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
                                  todoContents[index].title,
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(height: 4),
                                Row(children: [
                                  Text(todoContents[index].id.toString(),
                                      style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 2),
                                  Flexible(
                                      child: Text(todoContents[index].details)),
                                ]),
                                SizedBox(height: 5),
                                Text(todoContents[index].timestamp.toString(),
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  EditToDo(String title, String details, int index) {
    //index = todoContents.last.id + 1;

    if (mounted) {
      setState(() {
        todoContents.add(TodoData(
          title: title,
          details: details,
          id: index + 1,
        ));
      });
    }
  }
}

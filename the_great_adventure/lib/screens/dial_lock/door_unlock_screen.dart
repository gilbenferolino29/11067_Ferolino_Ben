// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_great_adventure/screens/dial_lock/safe_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Cracker',
      home: SafeCracker(),
    );
  }
}

class SafeCracker extends StatefulWidget {
  const SafeCracker({Key? key}) : super(key: key);

  @override
  State<SafeCracker> createState() => _SafeCrackerState();
}

class _SafeCrackerState extends State<SafeCracker> {
  List<int> values = [0, 0, 0];
  String combination = "696";
  bool isUnlocked = false;
  String feedback = '';
  late List<FixedExtentScrollController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _controllers.add(
        FixedExtentScrollController()); // For manual or chevron functionality
    _controllers.add(FixedExtentScrollController());
    _controllers.add(FixedExtentScrollController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 54, 24),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isUnlocked
                    ? CupertinoIcons.lock_open_fill
                    : CupertinoIcons.lock_fill,
                size: 128,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialWidget(
                      controller: _controllers[0],
                      onSelectedItemChanged: (index) => values[0] = index),
                  DialWidget(
                      controller: _controllers[1],
                      onSelectedItemChanged: (index) => values[1] = index),
                  DialWidget(
                      controller: _controllers[2],
                      onSelectedItemChanged: (index) => values[2] = index),
                ],
              ),
              SizedBox(height: 20),
              if (feedback.isNotEmpty)
                Text(feedback,
                    style: TextStyle(
                        color: isUnlocked
                            ? Color.fromARGB(255, 23, 233, 30)
                            : Color.fromARGB(255, 238, 223, 20))),
              SizedBox(height: 20),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: unlockSafe,
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(isUnlocked ? 'Lock' : 'Unlock'),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Navigator.of(context).pop(isUnlocked);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Text('Back'),
                ),
              ),
            ],
          ),
        ));
  }

  bool checkCombination() {
    String theCurrentValue = convertValuesToComparableString(values);
    bool isUnlocked = (theCurrentValue == combination);
    return isUnlocked;
  }

  String convertValuesToComparableString(List<int> val) {
    String temp = "";
    for (int v in val) {
      temp += "$v";
    }
    return temp;
  }

  unlockSafe() {
    if (isUnlocked) {
      _controllers[0].animateToItem(0,
          duration: Duration(seconds: 1), curve: Curves.easeInOutBack);
      _controllers[1].animateToItem(0,
          duration: Duration(seconds: 1), curve: Curves.easeInOutBack);
      _controllers[2].animateToItem(0,
          duration: Duration(seconds: 1), curve: Curves.easeInOutBack);
      setState(() {
        isUnlocked = false;
        feedback = "";
      });
    } else if (checkCombination()) {
      setState(() {
        isUnlocked = true;
        feedback = "Congratulations! You unlocked the safe!";
      });
    } else {
      setState(() {
        isUnlocked = false;
        feedback = "Oops! Wrong combination please try again!";
      });
    }
  }
}

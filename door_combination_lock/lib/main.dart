// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'resources/dial_widget.dart';

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
  String combination = "420";
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
              SizedBox(
                width: 400,
                height: 400,
                child: Image.asset(isUnlocked
                    ? 'assets/images/open.png'
                    : 'assets/images/close.png'),
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
              if (feedback.isNotEmpty) Text(feedback),
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
      _controllers[0].jumpToItem(0);
      _controllers[1].jumpToItem(0);
      _controllers[2].jumpToItem(0);
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

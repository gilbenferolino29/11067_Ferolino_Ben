import 'package:flutter/material.dart';

class DialWidget extends StatelessWidget {
  DialWidget({
    Key? key,
    required this.onSelectedItemChanged,
    required this.controller,
  }) : super(key: key);

  final Function(int) onSelectedItemChanged;
  final FixedExtentScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 7, bottom: 7),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 70,
        width: 50,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          onSelectedItemChanged: onSelectedItemChanged,
          itemExtent: 30,
          useMagnifier: true,
          magnification: 1.15,
          diameterRatio: 1.5,
          physics: FixedExtentScrollPhysics(),
          childDelegate: ListWheelChildLoopingListDelegate(
            children: List<Widget>.generate(
                10,
                (index) => Container(
                    alignment: Alignment.center,
                    width: 30,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text(
                      '$index',
                      textAlign: TextAlign.center,
                    ))),
          ),
        ),
      ),
    );
  }
}

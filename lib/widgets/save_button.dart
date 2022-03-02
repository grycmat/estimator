import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SaveButton extends StatelessWidget {
  SaveButton({Key? key, required this.onPressed, this.size = 36})
      : super(key: key);

  final Function onPressed;
  double size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
          height: 57,
          child: Icon(
            UniconsSolid.check,
            size: size,
          )),
    );
  }
}

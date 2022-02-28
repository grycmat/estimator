import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
          height: 57,
          child: const Icon(
            UniconsSolid.check,
            size: 36,
          )),
    );
  }
}

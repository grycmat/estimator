import 'package:flutter/material.dart';

class EstimationsView extends StatelessWidget {
  const EstimationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slider(min: 1, max: 10, value: 5, onChanged: (value) {}),
    );
  }
}

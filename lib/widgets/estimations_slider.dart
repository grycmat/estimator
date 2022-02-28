import 'package:estimator/models/estimate.dart';
import 'package:estimator/models/task.dart';
import 'package:flutter/material.dart';

class EstimationsSlider extends StatelessWidget {
  const EstimationsSlider({Key? key, required this.data}) : super(key: key);
  final EstimateData data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliderTheme(
        data: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        child: Slider(
          min: data.min,
          max: data.max,
          value: data.average,
          onChanged: (value) {},
        ),
      ),
    );
  }
}

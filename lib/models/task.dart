import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimator/models/estimate.dart';

class Task {
  String name = '';
  String id = '';
  List<Estimate> estimations = [];

  Task({required this.name});

  Task.fromMap(QueryDocumentSnapshot document) {
    id = document.id;
    var taskMap = document.data() as Map<String, dynamic>;
    List<dynamic> estimationsList = taskMap['estimations'];
    name = taskMap['name'];
    for (var element in estimationsList) {
      addEstimation(Estimate(
        userId: element['userId'],
        value: element['value'],
      ));
    }
  }

  addEstimation(Estimate estimation) {
    estimations.add(estimation);
  }

  EstimateData calculateEstimations() {
    double? min;
    var average = 0.0;
    double? max;
    for (var element in estimations) {
      if (min == null || element.value < min) {
        min = element.value.toDouble();
      }
      if (max == null || element.value > max) {
        max = element.value.toDouble();
      }
      average += element.value;
    }
    average = average / estimations.length;
    return EstimateData(average: average, min: min!, max: max!);
  }

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from(
        {'name': name, 'estimations': _estimationsToMap()});
  }

  List<Map<String, dynamic>> _estimationsToMap() {
    return estimations.map((item) => item.toMap()).toList();
  }
}

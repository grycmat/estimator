import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  Task({required this.name});
  Task.fromMap(QueryDocumentSnapshot document) {
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
  String name = '';
  List<Estimate> estimations = [];

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

class Estimate {
  Estimate({required this.userId, required this.value});
  String userId = '';
  int value = 0;

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from({'userId': userId, 'value': value});
  }
}

class EstimateData {
  EstimateData({required this.min, required this.max, required this.average});

  double min;
  double max;
  double average;
}

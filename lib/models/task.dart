import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimator/models/estimate.dart';

class Task {
  String _name = '';
  String projectId = '';
  String id = '';
  String approvedEstimation = '';
  List<Estimate> estimations = [];

  Task({required String name, required this.projectId}) {
    _name = name;
  }

  set name(val) => _name = val;
  get name => _name;

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

  Estimate addEstimation(Estimate estimation) {
    estimations.add(estimation);
    return estimation;
  }

  Estimate getUserEstimation(String userId) {
    return estimations.firstWhere((element) => element.userId == userId,
        orElse: (() {
      var estimate = Estimate(userId: userId, value: 0);
      addEstimation(estimate);
      return estimate;
    }));
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

  void updateEstimation({required String userId, required int value}) {
    print({userId, value});
    getUserEstimation(userId).value = value;
  }

  upsert() {
    FirebaseFirestore.instance.collection('project_estimation');
  }
}

class Task {
  Task({required this.name});

  String name = '';
  List<Estimate> estimations = [];

  addEstimation(Estimate estimation) {
    estimations.add(estimation);
  }
}

class Estimate {
  Estimate({required this.userId, required this.value});
  String userId = '';
  int value = 0;
}

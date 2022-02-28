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

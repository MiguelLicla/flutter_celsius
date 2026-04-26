class TemperaturaModel {
  final double celsius;
  final double fahrenheit;

  TemperaturaModel({required this.celsius, required this.fahrenheit});

  factory TemperaturaModel.fromJson(Map<String, dynamic> json) {
    return TemperaturaModel(
      celsius: (json['celsius'] as num).toDouble(),
      fahrenheit: (json['fahrenheit'] as num).toDouble(),
    );
  }
}

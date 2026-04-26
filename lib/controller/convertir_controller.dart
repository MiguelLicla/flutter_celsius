import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/temperatura_model.dart';

class ConvertirController {
  static const String _apiUrl = 'https://proyectoflask-01-79m4.onrender.com/convertir';

  Future<TemperaturaModel> convertir(double celsius) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'celsius': celsius}),
    );

    if (response.statusCode == 200) {
      return TemperaturaModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al conectar con la API');
    }
  }
}

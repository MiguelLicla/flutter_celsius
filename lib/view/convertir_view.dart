import 'package:flutter/material.dart';
import '../controller/convertir_controller.dart';
import '../model/temperatura_model.dart';

class ConvertirView extends StatefulWidget {
  const ConvertirView({super.key});

  @override
  State<ConvertirView> createState() => _ConvertirViewState();
}

class _ConvertirViewState extends State<ConvertirView> {
  final _controller = ConvertirController();
  final _inputController = TextEditingController();
  TemperaturaModel? _resultado;
  bool _cargando = false;
  String? _error;

  Future<void> _convertir() async {
    final texto = _inputController.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _cargando = true;
      _error = null;
      _resultado = null;
    });

    try {
      final resultado = await _controller.convertir(double.parse(texto));
      setState(() => _resultado = resultado);
    } catch (e) {
      setState(() => _error = 'No se pudo conectar con la API');
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celsius → Fahrenheit'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Grados Celsius',
                border: OutlineInputBorder(),
                suffixText: '°C',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cargando ? null : _convertir,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _cargando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Convertir', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24),
            if (_resultado != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  '${_resultado!.celsius}°C = ${_resultado!.fahrenheit}°F',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

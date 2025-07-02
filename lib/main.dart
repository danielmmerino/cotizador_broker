import 'package:flutter/material.dart';

void main() {
  runApp(const InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotizador de Seguros',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Seleccione el tipo de seguro que desea cotizar:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _open(context, const CarInsurancePage()),
                child: const Text('Seguro de Auto'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _open(context, const HealthInsurancePage()),
                child: const Text('Seguro de Salud'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarInsurancePage extends StatelessWidget {
  const CarInsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seguro de Auto')),
      body: const Center(
        child: Text('Contenido de seguro de auto'),
      ),
    );
  }
}

class HealthInsurancePage extends StatelessWidget {
  const HealthInsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seguro de Salud')),
      body: const Center(
        child: Text('Contenido de seguro de salud'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'pages/landing_page.dart'; // Importa el archivo nuevo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotizador de Seguros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LandingPage(), // Página inicial
    );
  }
}

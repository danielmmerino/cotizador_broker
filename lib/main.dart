import 'package:flutter/material.dart';
import 'pages/landing_page.dart'; // Importa el archivo nuevo
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await AuthService().login();
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

import 'package:flutter/material.dart';
import '../widgets/whatsapp_button.dart';

class CotizadorAutoPage extends StatelessWidget {
  const CotizadorAutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotizador Auto'),
      ),
      floatingActionButton: const WhatsappButton(),
      body: const SafeArea(
        child: Center(
          child: Text('Pantalla de cotizador de auto'),
        ),
      ),
    );
  }
}

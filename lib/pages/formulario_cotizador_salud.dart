import 'package:flutter/material.dart';

class FormularioCotizadorSaludPage extends StatelessWidget {
  final List<String> orderedAspects;

  const FormularioCotizadorSaludPage({
    super.key,
    required this.orderedAspects,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Cotizador Salud'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Orden seleccionado:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < orderedAspects.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('${i + 1}. ${orderedAspects[i]}'),
              ),
            const SizedBox(height: 20),
            // Aquí se podrían agregar campos del formulario
          ],
        ),
      ),
    );
  }
}

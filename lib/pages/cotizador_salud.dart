import 'package:flutter/material.dart';

import 'formulario_cotizador_salud.dart';
import '../widgets/whatsapp_button.dart';

class CotizadorSaludPage extends StatefulWidget {
  const CotizadorSaludPage({super.key});

  @override
  State<CotizadorSaludPage> createState() => _CotizadorSaludPageState();
}

class _CotizadorSaludPageState extends State<CotizadorSaludPage> {
  final List<String> _aspects = [
    'Monto de cobertura - Suma asegurada',
    'Red de hospitales donde atenderme',
    'Precio que pagaré por el servicio',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const WhatsappButton(),
        appBar: AppBar(
          title: const Text('Cotizador de Salud'),
        ),
        body: SafeArea(
            child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Ordena los aspectos más importantes para ti al momento de seleccionar un seguro:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ReorderableListView.builder(
                      itemCount: _aspects.length,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = _aspects.removeAt(oldIndex);
                          _aspects.insert(newIndex, item);
                        });
                      },
                      itemBuilder: (context, index) {
                        final aspect = _aspects[index];
                        return Card(
                          key: ValueKey(aspect),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(aspect),
                            //trailing: const Icon(Icons.drag_handle),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormularioCotizadorSaludPage(
                            orderedAspects: List<String>.from(_aspects),
                          ),
                        ),
                      );
                    },
                    child: const Text('Cotizar'),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}

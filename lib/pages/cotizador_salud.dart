import 'package:flutter/material.dart';

class CotizadorSaludPage extends StatefulWidget {
  const CotizadorSaludPage({super.key});

  @override
  State<CotizadorSaludPage> createState() => _CotizadorSaludPageState();
}

class _CotizadorSaludPageState extends State<CotizadorSaludPage> {
  final List<String> _aspects = [
    'Precio',
    'Monto de cobertura',
    'Red de hospitales donde atenderme',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotizador de Salud'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ordena los aspectos m\u00e1s importantes al cotizar:',
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
                        trailing: const Icon(Icons.drag_handle),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

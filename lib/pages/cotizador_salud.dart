import 'package:flutter/material.dart';

import 'formulario_cotizador_salud.dart';
import '../widgets/whatsapp_button.dart';
import '../services/preferencias_salud_service.dart';
import '../models/preference_option.dart';

class CotizadorSaludPage extends StatefulWidget {
  const CotizadorSaludPage({super.key});

  @override
  State<CotizadorSaludPage> createState() => _CotizadorSaludPageState();
}

class _CotizadorSaludPageState extends State<CotizadorSaludPage> {
  final _service = PreferenciasSaludService();
  List<PreferenceOption> _options = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadOptions();
  }

  Future<void> _loadOptions() async {
    try {
      final options = await _service.fetchOptions();
      setState(() {
        _options = options;
      });
    } catch (_) {
      setState(() {
        _options = [];
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

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
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Ordena los aspectos más importantes para ti al momento de seleccionar un seguro:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ReorderableListView.builder(
                            buildDefaultDragHandles: false,
                            itemCount: _options.length,
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (newIndex > oldIndex) {
                                  newIndex -= 1;
                                }
                                final item = _options.removeAt(oldIndex);
                                _options.insert(newIndex, item);
                              });
                            },
                            itemBuilder: (context, index) {
                              final aspect = _options[index];
                              return ReorderableDragStartListener(
                                key: ValueKey(aspect.id),
                                index: index,
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(aspect.descripcion),
                                    trailing:
                                        const Icon(Icons.open_with_outlined),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _options.isEmpty
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          FormularioCotizadorSaludPage(
                                        orderedAspects:
                                            List<PreferenceOption>.from(_options),
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
        ),
      ),
    );
  }
}

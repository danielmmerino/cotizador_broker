import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/vehicle_info.dart';
import '../services/vehicle_info_service.dart';
import '../widgets/whatsapp_button.dart';

class PreferenciasCotizadorAutoPage extends StatefulWidget {
  const PreferenciasCotizadorAutoPage({super.key});

  @override
  State<PreferenciasCotizadorAutoPage> createState() =>
      _PreferenciasCotizadorAutoPageState();
}

class _PreferenciasCotizadorAutoPageState
    extends State<PreferenciasCotizadorAutoPage> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _service = VehicleInfoService();

  VehicleInfo? _info;
  bool _loading = false;

  @override
  void dispose() {
    _plateController.dispose();
    super.dispose();
  }

  Future<void> _consultar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _info = null;
    });
    try {
      final response = await _service.fetchVehicleInfo(_plateController.text);
      setState(() {
        _info = response;
      });
    } catch (e) {
      setState(() {
        _info = null;
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
      appBar: AppBar(
        title: const Text('Cotizador Auto'),
      ),
      floatingActionButton: const WhatsappButton(),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _plateController,
                      decoration: const InputDecoration(
                        labelText: 'Placa del vehículo',
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Campo obligatorio' : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loading ? null : _consultar,
                      child: _loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Consultar'),
                    ),
                    const SizedBox(height: 16),
                    if (_info != null)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            JsonEncoder.withIndent('  ').convert(_info!.toJson()),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

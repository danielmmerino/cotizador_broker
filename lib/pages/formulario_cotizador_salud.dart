import 'package:flutter/material.dart';
import '../widgets/whatsapp_button.dart';
import '../models/preference_option.dart';
import '../services/cotizar_salud_service.dart';
import '../models/salud_quote.dart';

class FormularioCotizadorSaludPage extends StatefulWidget {
  final List<PreferenceOption> orderedAspects;

  const FormularioCotizadorSaludPage({
    super.key,
    required this.orderedAspects,
  });

  @override
  State<FormularioCotizadorSaludPage> createState() =>
      _FormularioCotizadorSaludPageState();
}

class _FormularioCotizadorSaludPageState
    extends State<FormularioCotizadorSaludPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _cotizarService = CotizarSaludService();
  List<SaludQuote> _quotes = [];
  bool _loadingQuotes = false;

  String? _gender;
  DateTime? _birthDate;
  int? _age;

  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool get _showContactFields => _gender != null && _birthDate != null;

  @override
  void dispose() {
    _birthDateController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
        _birthDateController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
        _age = now.year - picked.year -
            ((now.month < picked.month ||
                    (now.month == picked.month && now.day < picked.day))
                ? 1
                : 0);
      });
    }
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    if (value.length > 100) {
      return 'Máximo 100 caracteres';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final result = _validateRequired(value);
    if (result != null) return result;
    if (!value!.contains('@') || !value.contains('.')) {
      return 'Correo inválido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final result = _validateRequired(value);
    if (result != null) return result;
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value!) || value.length < 7) {
      return 'Número inválido';
    }
    return null;
  }

  Future<void> _cotizar() async {
    if (!_formKey.currentState!.validate() || _age == null || _gender == null) {
      return;
    }
    setState(() {
      _loadingQuotes = true;
      _quotes = [];
    });
    try {
      final quotes = await _cotizarService.cotizar(
        preferencias: widget.orderedAspects,
        edad: _age!,
        genero: _gender!,
      );
      quotes.sort((a, b) => int.parse(a.orden).compareTo(int.parse(b.orden)));
      setState(() {
        _quotes = quotes;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cotizar')),
      );
    } finally {
      setState(() {
        _loadingQuotes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final option1 = widget.orderedAspects.isNotEmpty
        ? widget.orderedAspects[0].descripcion
        : '';
    final option2 = widget.orderedAspects.length > 1
        ? widget.orderedAspects[1].descripcion
        : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Cotizador Salud'),
      ),
      floatingActionButton: const WhatsappButton(),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Como tu prioridad para contratar el seguro son',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text('1. $option1'),
                      Text('2. $option2'),
                      const SizedBox(height: 8),
                      const Text(
                        'Sin embargo te recomendaremos las mejores opciones del mercado para que puedas estar protegido',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Para continuar necesitamos que llenes la siguiente información:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Género'),
                        items: const [
                          DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                          DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
                        ],
                        validator: (value) => value == null ? 'Campo obligatorio' : null,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _birthDateController,
                        decoration: const InputDecoration(
                          labelText: 'Fecha de nacimiento',
                        ),
                        readOnly: true,
                        validator: (value) => _birthDate == null ? 'Campo obligatorio' : null,
                        onTap: () => _selectBirthDate(context),
                      ),
                      if (_age != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Edad: $_age años'),
                        ),
                      const SizedBox(height: 16),
                      if (_showContactFields) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre de contacto',
                          ),
                          validator: _validateRequired,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono de contacto',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: _validatePhone,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _loadingQuotes ? null : _cotizar,
                          child: const Text('Cotizar'),
                        ),
                        if (_loadingQuotes)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        if (_quotes.isNotEmpty)
                          Column(
                            children: _quotes
                                .map((q) => _QuoteCard(quote: q))
                                .toList(),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final SaludQuote quote;

  const _QuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    final rating = int.tryParse(quote.puntuacion) ?? 0;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.business),
        title: Text(quote.nombreAseguradora,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quote.nombreProducto),
            Text('Valor: ${quote.valor}'),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


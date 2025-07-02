import 'package:flutter/material.dart';
import '../widgets/whatsapp_button.dart';

class FormularioCotizadorSaludPage extends StatefulWidget {
  final List<String> orderedAspects;

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

  @override
  Widget build(BuildContext context) {
    final option1 = widget.orderedAspects.isNotEmpty
        ? widget.orderedAspects[0]
        : '';
    final option2 = widget.orderedAspects.length > 1
        ? widget.orderedAspects[1]
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Formulario válido')),
                              );
                            }
                          },
                          child: const Text('Enviar'),
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


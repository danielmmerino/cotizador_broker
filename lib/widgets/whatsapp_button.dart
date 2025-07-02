import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappButton extends StatelessWidget {
  const WhatsappButton({super.key});

  Future<void> _openWhatsapp() async {
    const message =
        'Hola estoy interesado en adquirir un seguro, por favor envieme más información';
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/593960964032?text=$encodedMessage');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _openWhatsapp,
      backgroundColor: Colors.green,
      child: const Icon(Icons.whatsapp),
    );
  }
}

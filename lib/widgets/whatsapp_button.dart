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

  void _showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.chat_bubble, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Contactanos por whatsapp para solventar cualquier duda',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _openWhatsapp();
                },
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showChatDialog(context),
      backgroundColor: Colors.green,
      child: const Icon(Icons.chat),
    );
  }
}

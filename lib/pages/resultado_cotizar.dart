import 'package:flutter/material.dart';

import '../models/salud_quote.dart';

class ResultadoCotizarPage extends StatelessWidget {
  final List<SaludQuote> quotes;

  const ResultadoCotizarPage({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de Cotización'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return _QuoteCard(quote: quotes[index]);
              },
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.network(
                quote.urlImagenAseguradora,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business),
              ),
              title: Text(
                quote.nombreAseguradora,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Comprar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

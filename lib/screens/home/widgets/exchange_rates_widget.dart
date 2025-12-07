import 'package:flutter/material.dart';
import 'package:kuraimi/constants/app_strings.dart';

class ExchangeRatesWidget extends StatelessWidget {
  const ExchangeRatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final List<Map<String, String>> exchangeRates = [
      {'currency': s.usd, 'sell': '530', 'buy': '535'},
      {'currency': s.rsa, 'sell': '140', 'buy': '142'},
      {'currency': s.euro, 'sell': '600', 'buy': '605'},
      {'currency': s.gold, 'sell': '40000', 'buy': '40500'},
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.exchangeRates, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Table(
              columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1), 2: FlexColumnWidth(1)},
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor.withAlpha(100), width: 1)),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(s.currency, style: Theme.of(context).textTheme.titleSmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(s.sell, style: Theme.of(context).textTheme.titleSmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(s.buy, style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                ),
                ...exchangeRates.map((rate) {
                  return TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(rate['currency']!)),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(rate['sell']!)),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(rate['buy']!)),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TransactionsFilterBar extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterChanged;

  const TransactionsFilterBar({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'key': 'all', 'label': 'الكل'},
      {'key': 'income', 'label': 'دخل'},
      {'key': 'expense', 'label': 'مصروف'},
      {'key': 'transfer', 'label': 'تحويل'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = currentFilter == filter['key'];
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FilterChip(
                label: Text(filter['label']!),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    onFilterChanged(filter['key']!);
                  }
                },
                selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                checkmarkColor: Theme.of(context).colorScheme.primary,
                labelStyle: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


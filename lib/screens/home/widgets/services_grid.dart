import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';

class ServicesGrid extends StatelessWidget {
  final void Function(String) onServiceTap;
  const ServicesGrid({super.key, required this.onServiceTap});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final services = [
      {'icon': Icons.account_balance, 'label': s.svcAccounts, 'action': s.svcAccounts},
      {'icon': Icons.send, 'label': s.svcTransfer, 'action': s.svcTransfer},
      {'icon': Icons.payment, 'label': s.svcPayBills, 'action': s.svcPayBills},
      {'icon': Icons.phone_android, 'label': s.svcTopUp, 'action': s.svcTopUp},
      {'icon': Icons.credit_card, 'label': s.svcCards, 'action': s.svcCards},
      {'icon': Icons.qr_code, 'label': s.svcQRCode, 'action': s.svcQRCode},
      {'icon': Icons.location_on, 'label': s.svcBranches, 'action': s.svcBranches},
      {'icon': Icons.support_agent, 'label': s.svcSupport, 'action': s.svcSupport},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () => onServiceTap(service['action'] as String),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08), shape: BoxShape.circle),
                child: Icon(service['icon'] as IconData, color: Theme.of(context).colorScheme.primary, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                service['label'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

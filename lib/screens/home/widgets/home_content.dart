import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kuraimi/providers/theme_cubit.dart';
import 'package:kuraimi/screens/home/widgets/modern_balance_card.dart';
import 'package:kuraimi/themes/app_gradients.dart';
import 'user_info_card.dart';
import 'quick_actions.dart';
import 'transaction_list.dart';
import 'exchange_rates_widget.dart';
import '../animations/home_animations.dart';

class HomeContent extends StatefulWidget {
  final Map<String, dynamic> userData;
  final List<Map<String, dynamic>> transactions;

  const HomeContent({super.key, required this.userData, required this.transactions});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  late HomeAnimations animations;

  @override
  void initState() {
    super.initState();
    animations = HomeAnimations(this);
    animations.playAll();
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;

    return Container(
      decoration: BoxDecoration(gradient: AppGradients.backgroundGradient(isDarkMode)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            animations.buildAnimatedWidget(
              controller: animations.userInfoController,
              child: UserInfoCard(userData: widget.userData, isDarkMode: isDarkMode),
            ),
            const SizedBox(height: 20),
            animations.buildAnimatedWidget(controller: animations.balanceCardController, child: const BalanceCardsCarousel()),
            const SizedBox(height: 20),
            animations.buildAnimatedWidget(
              controller: animations.quickActionsController,
              child: QuickActions(onActionTap: _showMockAction, isDarkMode: isDarkMode),
            ),
            const SizedBox(height: 20),
            animations.buildAnimatedWidget(controller: animations.exchangeRatesController, child: const ExchangeRatesWidget()),
            const SizedBox(height: 20),
            animations.buildAnimatedWidget(
              controller: animations.transactionListController,
              child: TransactionList(
                transactions: widget.transactions,
                isLimited: true,
                isDarkMode: isDarkMode,
                onSeeAll: () => context.go('/transactions'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMockAction(String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(child: Text(action)),
            ],
          ),
          content: Text('المزيد من $action'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('إغلاق')),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Icon(Icons.check)),
          ],
        );
      },
    );
  }
}

class BalanceCardsCarousel extends StatefulWidget {
  const BalanceCardsCarousel({super.key});

  @override
  State<BalanceCardsCarousel> createState() => _BalanceCardsCarouselState();
}

class _BalanceCardsCarouselState extends State<BalanceCardsCarousel> {
  final balances = <CurrencyBalance>[
    const CurrencyBalance(code: 'YER', labelAr: 'ريال يمني', symbol: 'ر.ي', amountMasked: '672,345.54', iban: '3002140108'),
    const CurrencyBalance(code: 'SAR', labelAr: 'ريال سعودي', symbol: 'ر.س', amountMasked: '25,120.10', iban: '3002140108'),
    const CurrencyBalance(code: 'USD', labelAr: 'دولار أمريكي', symbol: 'USD', amountMasked: '4,210.00', iban: '3002140108'),
  ];

  bool hide = false;

  @override
  Widget build(BuildContext context) {
    const brand = Color(0xFF5E3FD1);
    return SizedBox(
      height: 176,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.92),
        itemCount: balances.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ModernBalanceCard(
            item: balances[i],
            brandColor: brand,
            patternAsset: 'assets/icon/art.svg',
            obscureAmount: hide,
            height: 170,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            onToggleObscure: () => setState(() => hide = !hide),
            onTransfer: () {
              /* go to /transfer */
            },
            onQr: () {
              /* open qr */
            },
          ),
        ),
      ),
    );
  }
}

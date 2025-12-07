import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kuraimi/providers/transactions_cubit.dart';
import 'package:kuraimi/widgets/bottom_navigation.dart';
import 'package:kuraimi/widgets/loading_indicator.dart';
import '../../constants/app_strings.dart';
import 'widgets/transactions_list_view.dart';
import 'widgets/transactions_filter_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionsCubit(),
      child: const _TransactionsScreenView(),
    );
  }
}

class _TransactionsScreenView extends StatelessWidget {
  const _TransactionsScreenView();

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.transactions),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TransactionsCubit>().loadTransactions(),
            tooltip: s.retry,
          ),
        ],
      ),
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
                  const SizedBox(height: 16),
                  Text(s.errorTitle, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(state.error!, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.read<TransactionsCubit>().loadTransactions(),
                    child: Text(s.retry),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              TransactionsFilterBar(
                currentFilter: state.filterType!,
                onFilterChanged: (type) => context.read<TransactionsCubit>().filterByType(type),
              ),
              Expanded(
                child: TransactionsListView(
                  transactions: state.filteredTransactions,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        currentTab: 1,
        onTabSelected: (index) => _handleTabNavigation(context, index),
      ),
    );
  }

  void _handleTabNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/profile');
        break;
      case 1:
        context.go('/transactions');
        break;
      case 2:
        context.go('/home');
        break;
      case 3:
        context.go('/services');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuraimi/services/mock_services.dart';

class TransactionsState {
  final List<Map<String, dynamic>> transactions;
  final bool isLoading;
  final String? error;
  final String? filterType; // 'all', 'income', 'expense', 'transfer'

  const TransactionsState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
    this.filterType = 'all',
  });

  TransactionsState copyWith({
    List<Map<String, dynamic>>? transactions,
    bool? isLoading,
    String? error,
    String? filterType,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      filterType: filterType ?? this.filterType,
    );
  }

  List<Map<String, dynamic>> get filteredTransactions {
    if (filterType == 'all') return transactions;
    return transactions.where((tx) => tx['type'] == filterType).toList();
  }
}

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(const TransactionsState(isLoading: true)) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final transactions = await MockDataService.getTransactions();
      emit(state.copyWith(
        transactions: transactions,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void filterByType(String type) {
    emit(state.copyWith(filterType: type));
  }

  void clearFilter() {
    emit(state.copyWith(filterType: 'all'));
  }
}


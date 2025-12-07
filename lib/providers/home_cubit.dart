import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuraimi/services/mock_services.dart';
import 'package:kuraimi/services/home_data_cache.dart';

class HomeState {
  final Map<String, dynamic>? userData;
  final List<Map<String, dynamic>>? transactions;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.userData,
    this.transactions,
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    Map<String, dynamic>? userData,
    List<Map<String, dynamic>>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      userData: userData ?? this.userData,
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(isLoading: true)) {
    _loadData();
  }

  Future<void> _loadData() async {
    // تحميل من الكاش أولاً
    if (HomeDataCache.initialized) {
      emit(HomeState(
        userData: HomeDataCache.userData,
        transactions: HomeDataCache.transactions,
        isLoading: false,
      ));
      return;
    }

    // تحميل بيانات جديدة
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final userData = await MockDataService.getUserData();
      final transactions = await MockDataService.getTransactions();

      HomeDataCache.setData(user: userData, txs: transactions);

      emit(HomeState(
        userData: userData,
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

  Future<void> refresh() async {
    HomeDataCache.clear();
    await _loadData();
  }
}


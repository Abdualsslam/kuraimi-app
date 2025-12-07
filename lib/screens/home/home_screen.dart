import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kuraimi/providers/home_cubit.dart';
import 'package:kuraimi/services/home_data_cache.dart';
import 'package:kuraimi/widgets/bottom_navigation.dart';
import 'package:kuraimi/widgets/loading_indicator.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/home_content.dart';
import '../../constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeCubit(), child: const _HomeScreenView());
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: HomeAppBar(
            userData: state.userData,
            onNotifications: () => _showNotifications(context),
            onLogout: () => _showLogoutDialog(context),
          ),
          body: _buildBody(context, state, s),
          extendBody: true,
          bottomNavigationBar: CustomBottomBar(currentTab: 2, onTabSelected: (index) => _handleTabNavigation(context, index)),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeState state, AppStrings s) {
    if (state.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoadingIndicator(size: 155),
            const SizedBox(height: 20),
            Text(s.loadingData, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      );
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(state.error!, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => context.read<HomeCubit>().refresh(), child: Text(s.retry)),
          ],
        ),
      );
    }

    if (state.userData == null || state.transactions == null) {
      return const Center(child: LoadingIndicator());
    }

    return HomeContent(userData: state.userData!, transactions: state.transactions!);
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

  void _showNotifications(BuildContext context) {
    final s = AppStrings.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications),
                const SizedBox(width: 12),
                Text(s.notificationsTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                GestureDetector(onTap: () => Navigator.pop(context), child: Text(s.close)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final s = AppStrings.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(s.stSupport),
        content: Text(s.aboutApp),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(s.cancel)),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/');
              HomeDataCache.clear();
            },
            child: Text(s.close),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeAnimations {
  final TickerProvider vsync;
  
  late AnimationController userInfoController;
  late AnimationController balanceCardController;
  late AnimationController quickActionsController;
  late AnimationController transactionListController;
  late AnimationController exchangeRatesController;

  HomeAnimations(this.vsync) {
    _initControllers();
  }

  void _initControllers() {
    userInfoController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    balanceCardController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    quickActionsController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    transactionListController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    exchangeRatesController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
  }

  Future<void> playAll() async {
    await Future.delayed(const Duration(milliseconds: 100));
    userInfoController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    balanceCardController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    quickActionsController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    exchangeRatesController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    transactionListController.forward();
  }

  Widget buildAnimatedWidget({
    required AnimationController controller,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeOut),
        ),
        child: child,
      ),
    );
  }

  void dispose() {
    userInfoController.dispose();
    balanceCardController.dispose();
    quickActionsController.dispose();
    transactionListController.dispose();
    exchangeRatesController.dispose();
  }
}


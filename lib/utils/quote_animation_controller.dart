import 'package:flutter/material.dart';

class QuoteAnimationManager {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  void initialize(TickerProvider vsync) {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  Future<void> playAnimation() async {
    await animationController.forward(from: 0.0);
  }

  void dispose() {
    animationController.dispose();
  }
}
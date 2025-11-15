import 'package:flutter/material.dart';
import '../utils/quote_animation_controller.dart';

class QuoteDisplayCard extends StatelessWidget {
  final String quote;
  final QuoteAnimationManager animationManager;

  const QuoteDisplayCard({
    Key? key,
    required this.quote,
    required this.animationManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: AnimatedBuilder(
        animation: animationManager.animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: animationManager.scaleAnimation.value,
            child: Opacity(
              opacity: animationManager.fadeAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.format_quote,
                      color: Colors.purpleAccent,
                      size: 48,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      quote,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
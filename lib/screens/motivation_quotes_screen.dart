import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../services/shake_service.dart';
import '../data/quotes_data.dart';
import '../utils/quote_animation_controller.dart';
import '../widgets/quote_display_card.dart';
import '../widgets/app_header.dart';
import '../widgets/shake_instructions.dart';

class MotivationQuotesScreen extends StatefulWidget {
  const MotivationQuotesScreen({Key? key}) : super(key: key);

  @override
  State<MotivationQuotesScreen> createState() => _MotivationQuotesScreenState();
}

class _MotivationQuotesScreenState extends State<MotivationQuotesScreen>
    with SingleTickerProviderStateMixin {
  final ShakeService _shakeService = ShakeService();
  final QuoteAnimationManager _animationManager = QuoteAnimationManager();
  final Random _random = Random();

  String _currentQuote = QuotesData.getInitialMessage();
  bool _isAnimating = false;
  int _shakeCount = 0;

  @override
  void initState() {
    super.initState();
    _animationManager.initialize(this);
    _startShakeListener();
    _listenToShakeEvents();
  }

  Future<void> _startShakeListener() async {
    final started = await _shakeService.startShakeDetection();
    if (started) {
      print('Shake detection started successfully');
    }
  }

  void _listenToShakeEvents() {
    _shakeService.shakeStream.listen(
          (event) {
        if (event == 'shake_detected') {
          _onShakeDetected();
        }
      },
      onError: (error) {
        print('Error receiving shake events: $error');
      },
    );
  }

  void _onShakeDetected() {
    if (_isAnimating) return;

    setState(() {
      _currentQuote = QuotesData.motivationalQuotes[
      _random.nextInt(QuotesData.motivationalQuotes.length)];
      _isAnimating = true;
      _shakeCount++;
    });

    _animationManager.playAnimation().then((_) {
      setState(() {
        _isAnimating = false;
      });
    });

    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _shakeService.stopShakeDetection();
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(shakeCount: _shakeCount),
              Expanded(
                child: Center(
                  child: QuoteDisplayCard(
                    quote: _currentQuote,
                    animationManager: _animationManager,
                  ),
                ),
              ),
              const ShakeInstructions(),
            ],
          ),
        ),
      ),
    );
  }
}
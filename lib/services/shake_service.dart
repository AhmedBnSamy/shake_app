import 'package:flutter/services.dart';

class ShakeService {
  // Singleton pattern
  static final ShakeService _instance = ShakeService._internal();
  factory ShakeService() => _instance;
  ShakeService._internal();

  // Communication channels
  static const EventChannel _shakeEventChannel =
  EventChannel('com.example.shake_app/shake_events');
  static const MethodChannel _shakeMethodChannel =
  MethodChannel('com.example.shake_app/shake_control');

  Stream<String>? _shakeStream;

  /// Listen to shake events from native Android
  Stream<String> get shakeStream {
    _shakeStream ??= _shakeEventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
    return _shakeStream!;
  }

  /// Start shake detection on native side
  Future<bool> startShakeDetection() async {
    try {
      final result = await _shakeMethodChannel.invokeMethod('startShakeDetection');
      return result == true;
    } on PlatformException catch (e) {
      print('Failed to start shake detection: ${e.message}');
      return false;
    }
  }

  /// Stop shake detection on native side
  Future<bool> stopShakeDetection() async {
    try {
      final result = await _shakeMethodChannel.invokeMethod('stopShakeDetection');
      return result == true;
    } on PlatformException catch (e) {
      print('Failed to stop shake detection: ${e.message}');
      return false;
    }
  }
}
package com.example.shake_app

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlin.math.sqrt

class MainActivity: FlutterActivity() {
    private val SHAKE_EVENT_CHANNEL = "com.example.shake_app/shake_events"
    private val SHAKE_METHOD_CHANNEL = "com.example.shake_app/shake_control"

    private var sensorManager: SensorManager? = null
    private var accelerometer: Sensor? = null
    private var shakeDetector: ShakeDetector? = null
    private var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize sensor manager
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        // Setup EventChannel for shake events
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, SHAKE_EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            })

        // Setup MethodChannel for control commands
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SHAKE_METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startShakeDetection" -> {
                        startShakeDetection()
                        result.success(true)
                    }
                    "stopShakeDetection" -> {
                        stopShakeDetection()
                        result.success(true)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }
    }

    private fun startShakeDetection() {
        if (shakeDetector == null) {
            shakeDetector = ShakeDetector { onShakeDetected() }
        }

        accelerometer?.let {
            sensorManager?.registerListener(
                shakeDetector,
                it,
                SensorManager.SENSOR_DELAY_UI
            )
        }
    }

    private fun stopShakeDetection() {
        shakeDetector?.let {
            sensorManager?.unregisterListener(it)
        }
    }

    private fun onShakeDetected() {
        eventSink?.success("shake_detected")
    }

    override fun onPause() {
        super.onPause()
        stopShakeDetection()
    }

    override fun onResume() {
        super.onResume()
        startShakeDetection()
    }

    override fun onDestroy() {
        super.onDestroy()
        stopShakeDetection()
        shakeDetector = null
    }
}

/**
 * Shake Detection Algorithm
 * Detects significant acceleration changes indicating a shake gesture
 */
class ShakeDetector(private val onShakeListener: () -> Unit) : SensorEventListener {

    // Shake detection parameters
    private val SHAKE_THRESHOLD = 12.0f // Acceleration threshold
    private val SHAKE_TIME_WINDOW = 500L // Time window in milliseconds
    private val SHAKE_COUNT_THRESHOLD = 2 // Number of shakes needed

    private var lastShakeTime = 0L
    private var shakeCount = 0
    private var lastX = 0f
    private var lastY = 0f
    private var lastZ = 0f
    private var initialized = false

    override fun onSensorChanged(event: SensorEvent?) {
        if (event?.sensor?.type != Sensor.TYPE_ACCELEROMETER) return

        val x = event.values[0]
        val y = event.values[1]
        val z = event.values[2]

        if (!initialized) {
            lastX = x
            lastY = y
            lastZ = z
            initialized = true
            return
        }

        // Calculate acceleration change (delta)
        val deltaX = x - lastX
        val deltaY = y - lastY
        val deltaZ = z - lastZ

        // Calculate total acceleration magnitude
        val acceleration = sqrt(
            (deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ).toDouble()
        ).toFloat()

        val currentTime = System.currentTimeMillis()

        // Check if acceleration exceeds threshold
        if (acceleration > SHAKE_THRESHOLD) {
            // Check if within time window
            if (currentTime - lastShakeTime < SHAKE_TIME_WINDOW) {
                shakeCount++

                // Trigger shake event if threshold reached
                if (shakeCount >= SHAKE_COUNT_THRESHOLD) {
                    onShakeListener()
                    shakeCount = 0 // Reset counter
                    lastShakeTime = currentTime + 1000 // Cooldown period
                }
            } else {
                // Start new shake sequence
                shakeCount = 1
                lastShakeTime = currentTime
            }
        }

        // Reset shake count if too much time has passed
        if (currentTime - lastShakeTime > SHAKE_TIME_WINDOW) {
            shakeCount = 0
        }

        // Update last values
        lastX = x
        lastY = y
        lastZ = z
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        // Not needed for this implementation
    }
}
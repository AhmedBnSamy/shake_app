# 🎯 Shake for Motivation


---

## ✨ Features

- 📱 **Smart Shake Detection** - Advanced accelerometer-based gesture recognition
- 💜 **Modern UI/UX** - Sleek dark theme with purple accents
- 🎯 **Curated Quotes** - Handpicked collection of motivational wisdom
- ⚡ **Instant Response** - Real-time quote generation on shake
- 🎨 **Material Design 3** - Latest design system implementation
- 🔄 **Smooth Animations** - Fluid transitions and micro-interactions
- 📲 **Native Integration** - Deep Android platform integration via Method/Event Channels



## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** `>=3.0.0`
- **Dart SDK** `>=3.0.0`
- **Android Studio** Narwhal 2025.1.3+ or IntelliJ IDEA
- **Android SDK** API level 21+
- **JDK** 11 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AhmedBnSamy/shake_app.git
   cd shake_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Development mode
   flutter run
   
   # Release mode
   flutter run --release
   ```

## 📱 Usage

1. **Launch** the app on your Android device
2. **Hold** your device in a natural position
3. **Shake** to receive an inspiring quote
4. **Keep shaking** for continuous motivation! 💪

### Customizing Quotes

To add your own quotes, edit the quotes list in:
```dart
lib/data/quotes.dart
```

## 🏗️ Project Structure

```
shake_app/
│
├── android/                  # Android native code
│   ├── app/
│   │   └── src/main/
│   │       ├── kotlin/      # Kotlin implementation
│   │       │   └── MainActivity.kt
│   │       └── AndroidManifest.xml
│   └── build.gradle
│
├── lib/                     # Flutter/Dart code
│   ├── main.dart           # App entry point
│   ├── screens/            # UI screens
│   ├── services/           # Business logic
│   ├── models/             # Data models
│   └── widgets/            # Reusable components
│
├── pubspec.yaml            # Dependencies
└── README.md
```

## 🛠️ Built With

| Technology | Purpose |
|-----------|---------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Kotlin** | Android native implementation |
| **Material Design 3** | Design system |
| **Android Sensors API** | Accelerometer integration |
| **Gradle** | Build automation |

## 🔧 Configuration

### Shake Sensitivity

Adjust shake detection parameters in `MainActivity.kt`:

```kotlin
private val SHAKE_THRESHOLD = 12.0f        // Acceleration threshold
private val SHAKE_TIME_WINDOW = 500L       // Time window (ms)
private val SHAKE_COUNT_THRESHOLD = 2      // Shakes required
```

## 🐛 Troubleshooting

### Build Issues

```bash
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
flutter run
```

### Plugin Communication Errors

Ensure package names match across:
- `AndroidManifest.xml`
- `MainActivity.kt`
- `build.gradle`
- Dart channel declarations

### Shake Not Detected

- Check device has accelerometer sensor
- Verify permissions in `AndroidManifest.xml`
- Test with more vigorous shaking

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📋 Roadmap

- [ ] Custom quote categories
- [ ] Share quotes to social media
- [ ] Favorite quotes collection
- [ ] Daily quote notifications
- [ ] Multiple language support
- [ ] Quote of the day widget

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ahmed Bn Samy**

- GitHub: [@AhmedBnSamy](https://github.com/AhmedBnSamy)
- LinkedIn: [@AhmedSamy]((https://www.linkedin.com/in/ahmedbnsamy/))

## 🙏 Acknowledgments

- Inspired by the need for daily motivation
- Quote collection curated from various motivational speakers and authors
- Flutter community for amazing resources

## 💖 Support

If you found this project helpful, consider:

- ⭐ Starring the repository
- 🐛 Reporting bugs
- 💡 Suggesting new features
- 📢 Sharing with others

---

<div align="center">

**Made with 💜 and Flutter**

*Shake your way to success!* 🚀

</div>

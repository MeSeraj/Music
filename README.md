# Music Player

A feature-rich Flutter music player application with a beautiful UI and smooth playback controls.

## Features

- 🎵 Play audio files from your device
- 📂 Browse and manage your music library
- ⏯️ Full playback controls (play, pause, skip, previous)
- 🔊 Volume control
- 📊 Progress bar with seek functionality
- 📱 Beautiful and intuitive UI
- 🎨 Material Design 3 theming
- 🌙 Dark mode support

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)
- A device or emulator for testing

### Installation

1. Clone the repository:
```bash
git clone https://github.com/MeSeraj/Music.git
cd Music
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── song.dart            # Song data model
├── providers/
│   └── music_provider.dart  # State management for music player
├── screens/
│   ├── home_screen.dart     # Main screen with playlist
│   └── player_screen.dart   # Full-screen player interface
└── widgets/                 # Reusable widgets (if needed)
```

## Dependencies

- **audioplayers**: Audio playback functionality
- **file_picker**: File selection from device storage
- **provider**: State management
- **path_provider**: Access to device storage paths

## Usage

1. Launch the app
2. Tap the "+" button to add songs from your device
3. Select one or more audio files
4. Tap on a song to start playing
5. Use the mini player at the bottom to control playback
6. Tap the mini player to open the full player screen

## Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web (limited audio format support)

## Screenshots

(Screenshots will be added after running the app)

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

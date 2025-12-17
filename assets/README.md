# Assets Directory

This directory is for storing application assets such as:

- Icons
- Images
- Audio files (for demo/testing)
- Fonts (if custom fonts are added)

## Usage

Place your asset files in this directory and reference them in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/
    - assets/icons/
    - assets/audio/
```

Then access them in your Dart code:

```dart
Image.asset('assets/icon.png')
```

## Note

For the music player to work, users will need to add their own audio files using the file picker feature in the app. This directory can be used for any app-specific assets like logos or default album art.

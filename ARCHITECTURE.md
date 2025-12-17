# Music Player Architecture

## Overview
This Flutter Music Player follows a clean architecture pattern with clear separation of concerns using the Provider state management pattern.

## Architecture Layers

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│  (UI Screens & Widgets)                 │
│                                         │
│  ┌──────────────┐   ┌──────────────┐  │
│  │ HomeScreen   │   │ PlayerScreen │  │
│  └──────────────┘   └──────────────┘  │
└─────────────────┬───────────────────────┘
                  │
                  │ consumes
                  ▼
┌─────────────────────────────────────────┐
│         State Management Layer          │
│           (Provider Pattern)            │
│                                         │
│      ┌────────────────────────┐        │
│      │   MusicProvider        │        │
│      │   - Playlist state     │        │
│      │   - Playback controls  │        │
│      │   - Audio player mgmt  │        │
│      └────────────────────────┘        │
└─────────────────┬───────────────────────┘
                  │
                  │ uses
                  ▼
┌─────────────────────────────────────────┐
│            Data Layer                   │
│       (Models & Services)               │
│                                         │
│  ┌────────────┐   ┌──────────────────┐ │
│  │ Song Model │   │ AudioPlayers     │ │
│  │            │   │ (External Pkg)   │ │
│  └────────────┘   └──────────────────┘ │
└─────────────────────────────────────────┘
```

## Key Components

### 1. Models (`lib/models/`)
- **Song**: Data model representing a music track
  - Properties: id, title, artist, filePath, duration
  - Serialization methods for data persistence

### 2. Providers (`lib/providers/`)
- **MusicProvider**: Core state management
  - Manages playlist
  - Controls audio playback
  - Handles player events
  - Notifies UI of state changes

### 3. Screens (`lib/screens/`)
- **HomeScreen**: Main interface
  - Displays playlist
  - Mini-player at bottom
  - Add/remove songs
  - Song selection

- **PlayerScreen**: Full player interface
  - Album art display
  - Song information
  - Playback controls
  - Progress bar with seek
  - Volume control

## Data Flow

```
User Action
    │
    ▼
UI Event (Button tap)
    │
    ▼
Provider Method Call
    │
    ▼
State Update + Audio Player Control
    │
    ▼
notifyListeners()
    │
    ▼
UI Rebuild (Consumer widgets)
    │
    ▼
Updated Display
```

## State Management Flow

1. **User Interaction**: User taps play button
2. **Event Handler**: HomeScreen/PlayerScreen calls provider method
3. **State Update**: MusicProvider updates internal state
4. **Audio Control**: Provider controls AudioPlayer instance
5. **Notification**: Provider calls notifyListeners()
6. **UI Update**: Consumer widgets rebuild with new state

## Key Features

### Playback Management
- Play/Pause toggle
- Skip to next/previous track
- Seek to specific position
- Volume control
- Auto-play next song on completion

### Playlist Management
- Add songs via file picker
- Remove songs from playlist
- Display current playlist
- Highlight currently playing song

### UI/UX
- Material Design 3
- Dark theme
- Responsive layouts
- Progress indicators
- Visual feedback for current song

## Dependencies

- **audioplayers**: Core audio playback functionality
- **file_picker**: File selection from device
- **provider**: State management solution
- **path_provider**: Access to device storage

## Error Handling

- Null safety throughout
- Boundary checks for playlist operations
- Proper async/await for audio operations
- Graceful handling of missing files

## Future Enhancements

- Shuffle and repeat modes
- Search functionality
- Playlists/Collections
- Album art extraction
- Background playback
- Media controls in notification
- Favorites/Like songs
- Audio equalizer
- Sleep timer

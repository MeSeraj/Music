import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/song.dart';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Song> _playlist = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _volume = 1.0;
  
  // Stream subscriptions for proper cleanup
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;

  MusicProvider() {
    _initializePlayer();
  }

  void _initializePlayer() {
    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      playNext();
    });
  }

  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  double get volume => _volume;
  Song? get currentSong => (_playlist.isEmpty || _currentIndex < 0 || _currentIndex >= _playlist.length)
      ? null
      : _playlist[_currentIndex];

  void addSong(Song song) {
    _playlist.add(song);
    notifyListeners();
  }

  Future<void> removeSong(int index) async {
    if (index >= 0 && index < _playlist.length) {
      // If removing the currently playing song, stop playback
      if (index == _currentIndex) {
        await stop();
      }
      
      _playlist.removeAt(index);
      
      // Adjust current index if needed
      if (_currentIndex >= _playlist.length) {
        _currentIndex = _playlist.isEmpty ? 0 : _playlist.length - 1;
      } else if (index < _currentIndex) {
        // If we removed a song before the current one, adjust the index
        _currentIndex--;
      }
      
      notifyListeners();
    }
  }

  Future<void> playSong(int index) async {
    if (index >= 0 && index < _playlist.length) {
      try {
        _currentIndex = index;
        final song = _playlist[index];
        
        // Stop current playback before starting new song
        await _audioPlayer.stop();
        
        // Attempt to play the song
        await _audioPlayer.play(DeviceFileSource(song.filePath));
        notifyListeners();
      } catch (e) {
        debugPrint('Error playing song: $e');
        // Reset state on error
        _isPlaying = false;
        _currentPosition = Duration.zero;
        notifyListeners();
        rethrow; // Rethrow to allow UI to handle the error
      }
    }
  }

  Future<void> togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        if (_playlist.isEmpty) return;
        if (_currentPosition == Duration.zero) {
          await playSong(_currentIndex);
        } else {
          await _audioPlayer.resume();
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling play/pause: $e');
      _isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> playNext() async {
    if (_playlist.isEmpty) return;
    try {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
      await playSong(_currentIndex);
    } catch (e) {
      debugPrint('Error playing next song: $e');
    }
  }

  Future<void> playPrevious() async {
    if (_playlist.isEmpty) return;
    try {
      _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
      await playSong(_currentIndex);
    } catch (e) {
      debugPrint('Error playing previous song: $e');
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayer.seek(position);
      notifyListeners();
    } catch (e) {
      debugPrint('Error seeking: $e');
    }
  }

  Future<void> setVolume(double value) async {
    try {
      _volume = value.clamp(0.0, 1.0);
      await _audioPlayer.setVolume(_volume);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _currentPosition = Duration.zero;
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping: $e');
    }
  }

  @override
  void dispose() {
    try {
      // Cancel all stream subscriptions to prevent memory leaks
      _playerStateSubscription?.cancel();
      _durationSubscription?.cancel();
      _positionSubscription?.cancel();
      _playerCompleteSubscription?.cancel();
      
      // Dispose audio player
      _audioPlayer.dispose();
    } catch (e) {
      debugPrint('Error disposing audio player: $e');
    }
    super.dispose();
  }
}

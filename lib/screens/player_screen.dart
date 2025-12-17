import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
        centerTitle: true,
      ),
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          final song = provider.currentSong;

          if (song == null) {
            return const Center(
              child: Text('No song selected'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Album Art Placeholder
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.music_note,
                    size: 120,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 40),

                // Song Title
                Text(
                  song.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),

                // Artist Name
                Text(
                  song.artist,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Progress Bar
                Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                      ),
                      child: Slider(
                        value: provider.totalDuration.inSeconds > 0
                            ? provider.currentPosition.inSeconds
                                .toDouble()
                                .clamp(0.0, provider.totalDuration.inSeconds.toDouble())
                            : 0.0,
                        max: provider.totalDuration.inSeconds.toDouble() > 0
                            ? provider.totalDuration.inSeconds.toDouble()
                            : 1.0,
                        onChanged: (value) {
                          if (provider.totalDuration.inSeconds > 0) {
                            provider.seekTo(Duration(seconds: value.toInt()));
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(provider.currentPosition)),
                          Text(_formatDuration(provider.totalDuration)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Playback Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 48,
                      onPressed: () {
                        provider.playPrevious();
                      },
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: IconButton(
                        icon: Icon(
                          provider.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        iconSize: 48,
                        color: Theme.of(context).colorScheme.onPrimary,
                        onPressed: () {
                          provider.togglePlayPause();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      iconSize: 48,
                      onPressed: () {
                        provider.playNext();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Volume Control
                Row(
                  children: [
                    const Icon(Icons.volume_down),
                    Expanded(
                      child: Slider(
                        value: provider.volume,
                        onChanged: (value) {
                          provider.setVolume(value);
                        },
                      ),
                    ),
                    const Icon(Icons.volume_up),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

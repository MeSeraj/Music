import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/music_provider.dart';
import '../models/song.dart';
import 'player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _pickAudioFiles(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: true,
    );

    if (result != null && context.mounted) {
      final provider = Provider.of<MusicProvider>(context, listen: false);
      for (var file in result.files) {
        if (file.path != null) {
          final song = Song(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: file.name.replaceAll(RegExp(r'\.[^\.]+$'), ''),
            artist: 'Unknown Artist',
            filePath: file.path!,
            duration: Duration.zero,
          );
          provider.addSong(song);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          if (provider.playlist.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.music_note,
                    size: 100,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No songs in playlist',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _pickAudioFiles(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Songs'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.playlist.length,
                  itemBuilder: (context, index) {
                    final song = provider.playlist[index];
                    final isCurrentSong = index == provider.currentIndex;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: isCurrentSong
                          ? Theme.of(context)
                              .colorScheme
                              .primaryContainer
                          : null,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            isCurrentSong && provider.isPlaying
                                ? Icons.music_note
                                : Icons.music_note_outlined,
                          ),
                        ),
                        title: Text(
                          song.title,
                          style: TextStyle(
                            fontWeight: isCurrentSong
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(song.artist),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            provider.removeSong(index);
                          },
                        ),
                        onTap: () {
                          provider.playSong(index);
                        },
                      ),
                    );
                  },
                ),
              ),
              if (provider.currentSong != null)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayerScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.music_note, size: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                provider.currentSong!.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                provider.currentSong!.artist,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            provider.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 32,
                          ),
                          onPressed: () {
                            provider.togglePlayPause();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickAudioFiles(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

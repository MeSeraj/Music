class Song {
  final String id;
  final String title;
  final String artist;
  final String filePath;
  final Duration duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.filePath,
    required this.duration,
  });

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as String,
      title: map['title'] as String,
      artist: map['artist'] as String,
      filePath: map['filePath'] as String,
      duration: Duration(seconds: map['duration'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'filePath': filePath,
      'duration': duration.inSeconds,
    };
  }
}

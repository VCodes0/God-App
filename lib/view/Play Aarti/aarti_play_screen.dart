import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AartiPlayScreen extends StatefulWidget {
  final String imageUrl;
  final String audioUrl;
  const AartiPlayScreen({
    super.key,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  State<AartiPlayScreen> createState() => _AartiPlayScreenState();
}

class _AartiPlayScreenState extends State<AartiPlayScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() => duration = newDuration);
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() => position = newPosition);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network(widget.imageUrl, fit: BoxFit.cover),
          // Overlay to darken background slightly
          Container(color: Colors.black.withValues(alpha: 0.5)),
          // Audio Controls
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Slider(
                  value: position.inSeconds.toDouble(),
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final newPosition = Duration(seconds: value.toInt());
                    await _audioPlayer.seek(newPosition);
                  },
                  activeColor: Colors.orange,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(position),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatTime(duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10, color: Colors.white),
                      onPressed: () {
                        _audioPlayer.seek(
                          Duration(seconds: position.inSeconds - 10),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 64,
                        color: Colors.orange,
                      ),
                      onPressed: () async {
                        if (isPlaying) {
                          await _audioPlayer.pause();
                        } else {
                          await _audioPlayer.play(UrlSource(widget.audioUrl));
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10, color: Colors.white),
                      onPressed: () {
                        _audioPlayer.seek(
                          Duration(seconds: position.inSeconds + 10),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

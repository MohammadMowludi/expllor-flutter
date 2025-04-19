import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class TallVideoWidget extends StatefulWidget {
  final Map<String, dynamic> post;

  const TallVideoWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<TallVideoWidget> createState() => _TallVideoWidgetState();
}

class _TallVideoWidgetState extends State<TallVideoWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.post['url']);
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.play();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          widget.post['thumbnail'] ?? 'https://via.placeholder.com/300x300.png?text=Loading...',
          fit: BoxFit.cover,
        ),
        if (_isInitialized)
          VideoPlayer(_controller),
        const Positioned(
          bottom: 4,
          right: 4,
          child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
        ),
      ],
    );
  }
}

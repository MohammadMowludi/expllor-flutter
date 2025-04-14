import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewItem extends StatefulWidget {
  final String videoUrl;
  const VideoPreviewItem({super.key, required this.videoUrl});

  @override
  State<VideoPreviewItem> createState() => _VideoPreviewItemState();
}

class _VideoPreviewItemState extends State<VideoPreviewItem> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.network(widget.videoUrl);
      await controller.initialize();
      controller.setVolume(0);
      controller.setLooping(true);
      controller.play();
      if (mounted) {
        setState(() {
          _controller = controller;
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading video: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _isInitialized ? _controller!.value.aspectRatio : 1,
      child: _isInitialized
          ? VideoPlayer(_controller!)
          : Container(
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}

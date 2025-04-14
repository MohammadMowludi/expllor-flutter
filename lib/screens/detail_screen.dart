import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late VideoPlayerController _videoController;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    if (widget.post['type'] == 'video') {
      _videoController = VideoPlayerController.network(widget.post['url'])
        ..initialize().then((_) {
          setState(() {});
          _videoController.play();
       //     _controller.setVolume(0);
        });
    }
  }
  

  @override
  void dispose() {
    if (widget.post['type'] == 'video') {
      _videoController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.post['type'] == 'video';

    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: isVideo
                ? _videoController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      )
                    : Center(child: CircularProgressIndicator())
                : Image.network(widget.post['url'], fit: BoxFit.cover),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                ),
                SizedBox(width: 10),
                Icon(Icons.comment),
                Spacer(),
                Icon(Icons.share),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Add a comment...",
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

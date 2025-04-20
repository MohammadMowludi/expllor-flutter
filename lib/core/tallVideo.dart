import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shimmer/shimmer.dart';

class TallVideo extends StatefulWidget {
  const TallVideo({Key? key ,required this.post}) : super(key: key);
  final Map<String, dynamic> post;

  @override
  State<TallVideo> createState() => _TallVideoState();
}

class _TallVideoState extends State<TallVideo> {
      late VideoPlayerController controller ;
     bool showShimmer=true;

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  void _initializeVideos() async {
         controller = VideoPlayerController.networkUrl(Uri.parse(widget.post['url']),videoPlayerOptions: VideoPlayerOptions
           (mixWithOthers: true,allowBackgroundPlayback: true));
        await controller.initialize();
        controller.setLooping(true);
        controller.setVolume(0);
          controller.play();
        if (mounted) {
          setState(() => showShimmer=false);
        }
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (showShimmer) {
      return Stack(
        fit: StackFit.expand,
        children: [
      Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.grey[300],
        ),
      ),
          Image.network(widget.post['thumb_url'], fit: BoxFit.cover),
          const Positioned(
            bottom: 4,
            right: 4,
            child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
          ),
        ],
      );
    }

    return InkWell(
      onTap: (){
        if(controller.value.isInitialized){
          
          controller.play();
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(controller),
          const Positioned(
            bottom: 4,
            right: 4,
            child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
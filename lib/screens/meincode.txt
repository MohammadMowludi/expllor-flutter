import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> posts = [
    //هر محتوایی که قراره وسط باشه یا چپ یا راست طوری که نوشته شده به ترتیب باید کد گذاری شود
   {'type': 'video', 'url': 'https://v.ftcdn.net/11/21/46/21/240_F_1121462188_3P2cGXzNE4ZLKOvrYaB2MZAGHXXhycP2_ST.mp4', 'isTall': true}, // ستون چپ
    {'type': 'image', 'url': 'https://picsum.photos/204'}, 
     {'type': 'image', 'url': 'https://picsum.photos/204'}, // وسط
      {'type': 'image', 'url': 'https://picsum.photos/204'}, 
       {'type': 'image', 'url': 'https://picsum.photos/204'}, 
        {'type': 'image', 'url': 'https://picsum.photos/204'}, 
         {'type': 'image', 'url': 'https://picsum.photos/204'}, 
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4', 'isTall': true}, // ستون راست
   // {'type': 'video', 'url': 'https://example.com/short1.mp4'}, // وسط (ویدیو کوچک)
    {'type': 'image', 'url': 'https://picsum.photos/204'}, 
     {'type': 'image', 'url': 'https://picsum.photos/204'}, // وسط
  //    {'type': 'image', 'url': 'https://picsum.photos/204'}, 
  {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4', 'isTall': true},
      {'type': 'image', 'url': 'https://picsum.photos/204'}, 
     {'type': 'image', 'url': 'https://picsum.photos/204'}, // وسط
      {'type': 'image', 'url': 'https://picsum.photos/204'}, 
       {'type': 'image', 'url': 'https://picsum.photos/204'}, 
        {'type': 'image', 'url': 'https://picsum.photos/204'}, 
         {'type': 'image', 'url': 'https://picsum.photos/204'}, 
           {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4', 'isTall': true},
  ];

  final Map<int, VideoPlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  void _initializeVideos() async {
    for (int i = 0; i < posts.length; i++) {
      if (posts[i]['type'] == 'video') {
        final controller = VideoPlayerController.network(posts[i]['url']);
        await controller.initialize();
        controller.setLooping(true);
        controller.setVolume(0);
        
        // فقط ویدیوهای بلند را پلی کنید
        if (posts[i]['isTall'] == true) {
          controller.play();
        }

        if (mounted) {
          setState(() => _controllers[i] = controller);
        }
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  int _getColumnIndex(int index) {
    // ویدیوهای بلند در ستون‌های چپ (0) و راست (2)
    if (posts[index]['type'] == 'video' && posts[index]['isTall'] == true) {
      return index % 2 == 0 ? 0 : 2;
    }
    // بقیه محتواها در ستون وسط (1)
    return 1;
  }

  Widget _buildMediaWidget(int index) {
    final post = posts[index];
    
    if (post['type'] == 'image') {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(post['url'], fit: BoxFit.cover),
          const Positioned(
            bottom: 4,
            right: 4,
            child: Icon(Icons.photo, size: 16, color: Colors.white),
          ),
        ],
      );
    }

    final isTallVideo = post['isTall'] == true;
    final controller = _controllers[index];

    if (!isTallVideo) {
      // ویدیوهای کوچک در ستون وسط
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://example.com/thumbnail.jpg', // جایگزین با تامبنیل ویدیو
            fit: BoxFit.cover,
          ),
          const Center(
            child: Icon(Icons.play_circle_fill, size: 40, color: Colors.white70),
          ),
        ],
      );
    }

    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayer(controller),
        const Positioned(
          bottom: 4,
          right: 4,
          child: Icon(Icons.play_arrow, size: 16, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Explore"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          // نوار جستجو
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(11),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          
          // شبکه محتوا
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: List.generate(posts.length, (index) {
                  final isTallVideo = posts[index]['type'] == 'video' && 
                                    posts[index]['isTall'] == true;
                  final column = _getColumnIndex(index);

                  return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: isTallVideo ? 2 : 1,
                    child: Container(
                      color: Colors.grey[300],
                      child: _buildMediaWidget(index),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
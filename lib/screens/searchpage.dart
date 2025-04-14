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
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/200'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/13392869_1080_1920_60fps.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/203'},
    {'type': 'video', 'url': 'https://videos.pexels.com/video-files/31387378/133928569_1080_1920_60fps.mp4'},
    {'type': 'image', 'url': 'https://picsum.photos/204'},
    {'type': 'image', 'url': 'https://picsum.photos/205'},
    {'type': 'image', 'url': 'https://picsum.photos/206'},
    {'type': 'image', 'url': 'https://picsum.photos/207'},
     {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
     {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
     {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
       {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
        {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
        {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
         {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
           {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
             {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
               {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},  {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
                 {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
             {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
                      {'type': 'video', 'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4'},
       ];
  
  final Map<int, VideoPlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < posts.length; i++) {
      if (posts[i]['type'] == 'video') {
        final controller = VideoPlayerController.network(posts[i]['url']);
controller.initialize().then((_) {
  print("Video initialized: $i");
  setState(() {});
  controller.setLooping(true);
  controller.setVolume(0);
  controller.play();
});
        _controllers[i] = controller;
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  bool _isLargeItem(int index) => index == 7;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(11),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          Expanded(
            
            child: Padding(
              
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: SingleChildScrollView (
                child: StaggeredGrid.count(
                  
                  crossAxisCount: 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  children: List.generate(posts.length, (index) {
                    final post = posts[index];
                    final isLarge = _isLargeItem(index);
                    final crossAxisCellCount = isLarge ? 2 : 1;
                    final mainAxisCellCount = isLarge ? 2 : 1;
                
                    return StaggeredGridTile.count(
                     crossAxisCellCount: 1,
                     mainAxisCellCount: index % 7 == 0 ? 2 : 1,
                      child: GestureDetector(
                        onTap: () {
                          // صفحه‌ی نمایش کامل پست
                        },
                        child: Container(
                          color: Colors.grey[300],
                          child: post['type'] == 'image'
                              ? Image.network(post['url'], fit: BoxFit.cover)
                              : (_controllers[index]?.value.isInitialized ?? false)
                                  ? VideoPlayer(_controllers[index]!)
                                  : Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

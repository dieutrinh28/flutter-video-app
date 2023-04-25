import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final dynamic video;
  const VideoPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<VideoPage> createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  bool showPlayIcon = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.video['video_url']);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        showPlayIcon = true;
                      });

                    },
                    onTapUp: (_) {
                      Future.delayed(const Duration(seconds: 3000)).then((value) {
                        setState(() {
                          showPlayIcon = false;
                        });
                      });
                    },
                    child: Stack(
                      children: [
                        controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              )
                            : Image.network(
                                widget.video['thumbnail_url'],
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                        if (showPlayIcon)
                          Positioned.fill(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.value.isPlaying
                                        ? controller.pause()
                                        : controller.play();
                                  });
                                },
                                icon: Icon(controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                iconSize: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                  const LinearProgressIndicator(
                    value: 0.4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.video['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            "${widget.video['views'].toString()} views - ${widget.video['likes'].toString()} likes"),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildAction(
                              context,
                              Icons.thumb_up_outlined,
                              widget.video['likes'].toString(),
                            ),
                            buildAction(
                              context,
                              Icons.thumb_down_outlined,
                              widget.video['dislikes'].toString(),
                            ),
                            buildAction(
                              context,
                              Icons.reply_outlined,
                              'Share',
                            ),
                            buildAction(
                              context,
                              Icons.download_outlined,
                              'Download',
                            ),
                            buildAction(
                              context,
                              Icons.library_add_outlined,
                              'Save',
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Name'),
                                  Text('1000 subscribers'),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'SUBSCRIBE',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAction(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}

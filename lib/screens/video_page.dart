import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatelessWidget {
  final dynamic video;
  const VideoPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = video['video_url'];
    List<String> urlSegments = url.split("/");
    String videoId = urlSegments.last;

    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                      /*Image.network(
                        video['thumbnail_url'],
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),*/
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 30,
                      ),
                    ],
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
                          video['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            "${video['views'].toString()} views - ${video['likes'].toString()} likes"),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildAction(
                              context,
                              Icons.thumb_up_outlined,
                              video['likes'].toString(),
                            ),
                            buildAction(
                              context,
                              Icons.thumb_down_outlined,
                              video['dislikes'].toString(),
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

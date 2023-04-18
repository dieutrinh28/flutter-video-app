import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_sliver_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List videoList = [];
  Stream videoListStream =
      FirebaseFirestore.instance.collection('videos').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(),
          StreamBuilder(
            stream: videoListStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(child: Text('Something went wrong')),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final document = snapshot.data?.docs[index];
                    String title = document['title'];
                    String videoUrl = document['video_url'];
                    String thumbnailUrl = document['thumbnail_url'];
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              thumbnailUrl,
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                  childCount: snapshot.data?.docs.length ?? 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

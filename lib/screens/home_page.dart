import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_app/services/video_manager.dart';
import 'package:video_app/widgets/video_card.dart';
import '../widgets/custom_sliver_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool isConnected = true;

  List videoList = [];
  Stream videoListStream = VideoManager.getVideoList();

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    final ConnectivityResult result = await connectivity.checkConnectivity();

    setState(() {
      isConnected = result != ConnectivityResult.none;
    });

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: Container(
        child: isConnected
            ? Text('Kết nối mạng ổn định')
            : Text('Không có kết nối mạng'),
      ),*/
       body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          StreamBuilder(
            stream: videoListStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Something went wrong')),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final video = snapshot.data?.docs[index];
                    return VideoCard(
                      video: video,
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

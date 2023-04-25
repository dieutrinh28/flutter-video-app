import 'package:cloud_firestore/cloud_firestore.dart';

class VideoManager {
  static Stream getVideoList() {
    return FirebaseFirestore.instance.collection('videos').snapshots();
  }
}
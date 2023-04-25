import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistManager {
  static Stream getPlaylists() {
    return FirebaseFirestore.instance.collection('playlists').snapshots();
  }

  static Future<void> createPlaylist(String newTitle, String privacy) async {
    try {
      await FirebaseFirestore.instance.collection('playlists').add(
        {
          'title': newTitle,
          'privacy': privacy,
        }
      );
    } catch (e) {
      print(e);
    }
  }
  
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/playlist_manager.dart';
import '../widgets/playlist_card.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => LibraryPageState();
}

class LibraryPageState extends State<LibraryPage> {
  List playlist = [];
  Stream playlistStream = PlaylistManager.getPlaylists();

  void onAddPlaylistClick() {
    String newTitle = "";
    String selectedPrivacyValue = "Public";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text('New playlist'),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (String value) {
                    newTitle = value;
                  },
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedPrivacyValue,
                  items: [
                    DropdownMenuItem(
                      value: "Private",
                      child: Row(
                        children: const [
                          Icon(Icons.lock_outline),
                          SizedBox(width: 16),
                          Text("Private"),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Public",
                      child: Row(
                        children: const [
                          Icon(Icons.public),
                          SizedBox(width: 16),
                          Text("Public"),
                        ],
                      ),
                    )
                  ],
                  underline: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      selectedPrivacyValue = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.cyanAccent,
                ),
              ),
              onPressed: () async {
                await PlaylistManager.createPlaylist(newTitle, selectedPrivacyValue);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Create',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        );
      },
    ).then((value) => playlistStream = PlaylistManager.getPlaylists());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddPlaylistClick,
        label: const Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: playlistStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (BuildContext context, int index) {
                      final playlist = snapshot.data.docs[index];
                      return PlaylistCard(
                        playlist: playlist,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

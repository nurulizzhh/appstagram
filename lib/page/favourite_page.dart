import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavouritePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _currentUsername = '';

  Future<void> _refreshUserData() async {
    await _getCurrentUserData();
    setState(() {
      // Memanggil setState agar tampilan diperbarui dengan data terbaru
    });
  }

  Future<void> _getCurrentUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(user.uid).get();

      Map<String, dynamic> userData = userSnapshot.data() ?? {};
      _currentUsername = userData['username'] as String? ?? '';
    }
  }

  void _showOptionsDialog(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Post'),
              onTap: () {
                Navigator.pop(context); // Tutup BottomSheet
                _editPost(data); // Panggil fungsi edit
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Post'),
              onTap: () {
                Navigator.pop(context); // Tutup BottomSheet
                _deletePost(data); // Konfirmasi dan hapus postingan
              },
            ),
          ],
        );
      },
    );
  }

  void _editPost(Map<String, dynamic> data) {
    TextEditingController _editedCaptionController =
        TextEditingController(text: data['caption']);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Edit Post',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _editedCaptionController,
                    decoration: InputDecoration(labelText: 'Caption'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // Cari dokumen dengan data yang cocok
                        QuerySnapshot<Map<String, dynamic>> matchingPosts =
                            await _firestore
                                .collection('posts')
                                .where('username', isEqualTo: data['username'])
                                .where('caption', isEqualTo: data['caption'])
                                .get();

                        if (matchingPosts.docs.isNotEmpty) {
                          // Ambil dokumen pertama yang cocok
                          var matchingPost = matchingPosts.docs.first;

                          // Lakukan update pada dokumen yang cocok
                          await _firestore
                              .collection('posts')
                              .doc(matchingPost.id)
                              .update({
                            'isFavorite': false,
                            'caption': _editedCaptionController.text.trim(),
                          });

                          Navigator.pop(context); // Tutup modal bottom sheet

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Post edited successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          // Dokumen tidak ditemukan
                          print('Matching document not found');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Matching document not found'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (e) {
                        print('Error editing post: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to edit post: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Fungsi untuk menghapus postingan
  void _deletePost(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Post?'),
          content: Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // Cari dokumen dengan data yang cocok
                  QuerySnapshot<Map<String, dynamic>> matchingPosts =
                      await _firestore
                          .collection('posts')
                          .where('username', isEqualTo: data['username'])
                          .where('caption', isEqualTo: data['caption'])
                          .get();

                  if (matchingPosts.docs.isNotEmpty) {
                    // Ambil dokumen pertama yang cocok
                    var matchingPost = matchingPosts.docs.first;

                    // Hapus dokumen yang cocok
                    await _firestore
                        .collection('posts')
                        .doc(matchingPost.id)
                        .delete();

                    Navigator.pop(context); // Tutup dialog konfirmasi

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Post deleted successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    // Dokumen tidak ditemukan
                    print('Matching document not found');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Matching document not found'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  print('Error deleting post: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete post: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleFavoriteStatus(Map<String, dynamic> data) async {
    try {
      QuerySnapshot<Map<String, dynamic>> matchingPosts = await _firestore
          .collection('posts')
          .where('username', isEqualTo: data['username'])
          .where('caption', isEqualTo: data['caption'])
          .get();

      if (matchingPosts.docs.isNotEmpty) {
        var matchingPost = matchingPosts.docs.first;

        // Pengecekan keberadaan field isFavorite
        bool isFavorite = data['isFavorite'] ?? false;

        await _firestore.collection('posts').doc(matchingPost.id).update({
          'isFavorite': !isFavorite,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                isFavorite ? 'Removed from Favorites' : 'Added to Favorites'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Matching document not found');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Matching document not found'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error toggling favorite status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to toggle favorite status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.grey[50],
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              child: Text(
                'My Favorites',
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('posts')
            .where('isFavorite', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Text('Oops, something went wrong');
            } else {
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.separated(
                itemCount: documents.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  return _listViewWidget(documents[index]);
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget _listViewWidget(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(data['profile']),
                    radius: 20,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    data['username'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _toggleFavoriteStatus(data);
                    },
                    icon: Icon(
                      data['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: data['isFavorite'] ? Colors.red : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showOptionsDialog(data); // Ubah pemanggilan fungsi ini
                    },
                    icon: Icon(
                      CupertinoIcons.ellipsis_vertical,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Image.network(data['photo']),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: Text(
              data['caption'],
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}

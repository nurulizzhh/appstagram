import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;

  TextEditingController _captionController = TextEditingController();
  TextEditingController _photoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  Future<void> _addPost() async {
    try {
      String caption = _captionController.text.trim();
      String photoURL = _photoController.text.trim();

      // Validate data
      if (caption.isEmpty || photoURL.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Caption and photo URL cannot be empty'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Load user data if not loaded yet
      await _loadUserData(); // Tunggu hingga _loadUserData() selesai

      // Add post to Firestore
      await _firestore.collection('posts').add({
        'username': _user.displayName,
        'profile': _user.photoURL,
        'caption': caption,
        'photo': photoURL,
        'isFavorite': false,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear text fields after successful addition
      _captionController.clear();
      _photoController.clear();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add post: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(_user.uid).get();

      Map<String, dynamic> userData = userSnapshot.data() ?? {};

      // Update user properties if available
      _user = _auth.currentUser!;
      _user.updateDisplayName(userData['username']);
      _user.updatePhotoURL(userData['photoURL']);

      setState(() {}); // Update the UI with the new user data
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          title: Text(
            'Add Post',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.black,
            ),
          ),
          actions: [
            Builder(builder: (BuildContext context) {
              return IconButton(
                color: Color.fromARGB(255, 86, 176, 250),
                icon: Icon(
                  CupertinoIcons.checkmark_alt,
                  size: 32,
                ),
                onPressed: () {
                  _addPost(); // Call the function to add post
                },
              );
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Caption',
                  style: TextStyle(color: Colors.black45),
                ),
                TextField(
                  controller: _captionController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Photo',
                  style: TextStyle(color: Colors.black45),
                ),
                TextField(
                  controller: _photoController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

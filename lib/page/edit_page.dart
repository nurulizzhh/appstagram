import 'package:appstagram/page/bottomnavbar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  late String _profile = '';

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(_user.uid).get();

    Map<String, dynamic> userData = userSnapshot.data() ?? {};

    _nameController.text = userData['name'] ?? '';
    _usernameController.text = userData['username'] ?? '';
    _emailController.text = _user.email ?? '';
    _bioController.text = userData['bio'] ?? '';
    _profile = userData['photoURL'];
  }

  Future<void> _updateUserData() async {
    try {
      // Update data di Firestore
      await _firestore.collection('users').doc(_user.uid).update({
        'name': _nameController.text,
        'username': _usernameController.text,
        'bio': _bioController.text,
      });

      // Update display name di Firebase Authentication
      await _user.updateDisplayName(_usernameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Arahkan pengguna ke halaman ProfilePage setelah berhasil memperbarui
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyBottomNavigationBar()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
            'Edit profile',
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
                  _updateUserData(); // Panggil fungsi pembaruan data
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
                // Widget-widget lain di sini
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(_profile),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                Text(
                  'Name',
                  style: TextStyle(color: Colors.black45),
                ),
                TextField(
                  controller: _nameController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Username',
                  style: TextStyle(color: Colors.black45),
                ),
                TextField(
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email',
                  style: TextStyle(color: Colors.black45),
                ),
                TextField(
                  controller: _emailController,
                  enabled: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Bio',
                  style: TextStyle(color: Colors.black45),
                ),
                TextField(
                  controller: _bioController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

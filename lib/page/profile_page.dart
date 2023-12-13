import 'package:appstagram/page/edit_page.dart';
import 'package:appstagram/page/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  late String _userId;
  late String _username = '';
  late String _profile = '';
  late String _name = '';
  late String _bio = '';
  late String _phone = '';
  late String _email = '';
  // Variabel untuk menyimpan username

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser!;
    _userId = _user.uid;

    // Ambil data pengguna dari Firestore berdasarkan UID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(_userId).get();

    // Dapatkan data pengguna
    Map<String, dynamic> userData = userSnapshot.data() ?? {};

    // Set nilai variabel _username
    setState(() {
      _username = userData['username'];
      _profile = userData['photoURL'];
      _name = userData['name'];
      _bio = userData['bio'];
      _phone = userData['phoneNumber'];
      _email = userData['email'];
    });
  }

  void _logout() async {
    try {
      await _auth.signOut();

      // Navigasi ke halaman login setelah logout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to logout: $e'),
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
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.grey[50],
          title: Row(
            children: [
              SizedBox(
                width: 10,
              ),
            ],
          ),
          actions: [
            Builder(builder: (BuildContext context) {
              return IconButton(
                color: Colors.black,
                icon: Icon(
                  CupertinoIcons.square_arrow_right,
                  size: 34,
                ),
                onPressed: () {
                  // Panggil fungsi logout saat tombol diklik
                  _logout();
                },
              );
            }),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Profile",
                    style: GoogleFonts.breeSerif(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(_profile),
              ),
              SizedBox(height: 16),
              Text(
                _name,
                style: GoogleFonts.varelaRound(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                _bio,
                style: GoogleFonts.varelaRound(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Divider(),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          _username,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Divider(),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          _email,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Divider(),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          _phone,
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Divider(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

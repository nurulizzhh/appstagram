import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _authService = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(
      String name,
      String username,
      String email,
      String password,
      String phoneNumber,
      String bio,
      String photoURL,
      BuildContext context) async {
    try {
      // 1. Daftar pengguna pada Firebase Authentication
      UserCredential credential = await _authService
          .createUserWithEmailAndPassword(email: email, password: password);

      // 2. Dapatkan ID pengguna yang terdaftar
      String userId = credential.user?.uid ?? '';

      // 3. Simpan informasi pengguna pada Firestore
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'bio': bio,
        'photoURL': photoURL,
        // tambahkan informasi lain yang dibutuhkan
      });

      return credential.user;
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
    }
    return null;
  }

  Future<User?> signIn(
      String username, String password, BuildContext context) async {
    try {
      UserCredential credential = await _authService.signInWithEmailAndPassword(
          email: username, password: password);
      return credential.user;
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _authService.signOut();
    } catch (e) {
      final String errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ));
    }
  }
}

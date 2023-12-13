import 'package:appstagram/page/login_page.dart';
import 'package:appstagram/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});
  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _photoURLController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
    _photoURLController.dispose();
    super.dispose();
  }

  void register() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String name = _nameController.text;
    String password = _passwordController.text;
    String phoneNumber = _phoneNumberController.text;
    String bio = _bioController.text;
    String photoURL = _photoURLController.text;

    User? user = await _authService.signUp(
      name,
      username,
      email,
      password,
      phoneNumber,
      bio,
      photoURL,
      context,
    );

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User is successfully registered"),
        backgroundColor: Colors.green,
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot register"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 30),
          Center(
            child: Text(
              'My Notes',
              style: TextStyle(
                fontFamily: 'Billabong',
                color: Colors.black,
                fontSize: 50,
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Email',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 92, 92, 92)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _usernameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Username',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 92, 92, 92)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Name',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 92, 92, 92)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _passwordController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _phoneNumberController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Phone Number',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 92, 92, 92)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _bioController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Bio',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 92, 92, 92)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _photoURLController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Photo URL',
                labelStyle:
                    TextStyle(color: const Color.fromARGB(255, 92, 92, 92)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: register,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have an account?"),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

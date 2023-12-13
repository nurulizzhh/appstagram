import 'package:appstagram/page/bottomnavbar_page.dart';
import 'package:appstagram/page/createaccount_page.dart';
import 'package:appstagram/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    User? user = await _authService.signIn(username, password, context);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login Success"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("cannot login"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'My Notes',
              style: TextStyle(
                  fontFamily: 'Billabong', color: Colors.black, fontSize: 50),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              controller: _usernameController,
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
          ElevatedButton(
              onPressed: (() {
                login();
              }),
              child: Container(
                padding: EdgeInsets.all(16),
                height: 50,
                width: 280,
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )),
          SizedBox(height: 20),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccountPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'feed_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _loading = false);
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => FeedScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF833AB4), //  purple
              Color(0xFFE1306C), //  pink
              Color(0xFFF77737), //  orange
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                color: Colors.white.withOpacity(0.95),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //  logo 
                        Icon(
                          Icons.camera_alt,
                          size: 64,
                          color: Color(0xFF833AB4),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'SocialFeed+',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(height: 32),
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Enter email' : null,
                        ),
                        SizedBox(height: 18),
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Enter password'
                              : null,
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              backgroundColor: Color(0xFFE1306C), // Pink
                            ),
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

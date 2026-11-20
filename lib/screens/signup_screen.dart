import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //TODO: 1. Deklarasi Variabel
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  //TODO 9. Buat metode signUp
  void _signUp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = _nameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _errorText = 'Minimal 8 karakter, kombinasi Huruf Kapital, huruf kecil, angka, simbol';
      });
      return;
    }

    setState(() {
      _errorText = '';
    });

    //simpan data di sharedPreferences
    prefs.setString('name', name);
    prefs.setString('username', username);
    prefs.setString('password', password);

    //navigasi ke SignInScreen
    Navigator.pushReplacementNamed(context, '/signin');
    // print('*** Sign Up Berhasil!');
    // print('Nama: $name');
    // print('Nama Pengguna: $username');
    // print('Kata Sandi: $password');
  }

  //TODO 10. Buat metode dispose
  @override
  void dispose() {
    //TODO Implemen dispose
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO 2. Padsang AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // The '<-' back arrow
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Sign Up'),
      ),
      //TODO 3. Pasang Body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                //TODO 4. Atur mainAxisAlignment dan crossAxisAlignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TODO 5. Pasang TextFormField Nama
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  //TODO 5. Pasang TextFormField Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Pengguna',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //TODO 6. Pasang TextFormField Kata Sandi
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  //TODO 7. Pasang ElevatedButton untuk Sign Up
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
                  //TODO 8. Pasang TextButton Sign In
                  SizedBox(height: 10),
                  //...
                  RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Masuk di sini.',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signin');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

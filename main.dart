import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/first.jpg"),
              height: 100,
              width: 100,
            ),
            Container(
              child: Text(
                "FirstTalk",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginButtonEnabled = false;
  bool _isPasswordVisible = false;
  String _emailErrorMessage = "";

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  void _updateLoginButtonState() {
    setState(() {
      bool isEmailValid = emailRegExp.hasMatch(_emailController.text);
      _emailErrorMessage = isEmailValid ? "" : "Please enter a valid email address.";
      _isLoginButtonEnabled = isEmailValid && _passwordController.text.length >= 6;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateLoginButtonState);
    _passwordController.addListener(_updateLoginButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email/Phone No",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      errorText: _emailErrorMessage.isEmpty ? null : _emailErrorMessage,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoginButtonEnabled
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsPage()),
                      );
                    }
                        : null,
                    child: Text("Login"),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationPage()),
                      );
                    },
                    child: Text("New to FirstTalk? Register here"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Reset Your Password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Enter your email",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password reset link sent to your email!"),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Reset Password"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRegisterButtonEnabled = false;
  bool _isPasswordVisible = false;
  String _emailErrorMessage = "";
  String _passwordErrorMessage = "";

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  void _updateRegisterButtonState() {
    setState(() {
      bool isEmailValid = emailRegExp.hasMatch(_emailController.text);
      _emailErrorMessage = isEmailValid ? "" : "Please enter a valid email address.";
      _passwordErrorMessage = _passwordController.text.length < 6
          ? "Password must be at least 6 characters"
          : "";
      _isRegisterButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          isEmailValid &&
          _passwordController.text.length >= 6;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateRegisterButtonState);
    _emailController.addListener(_updateRegisterButtonState);
    _passwordController.addListener(_updateRegisterButtonState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      errorText: _emailErrorMessage.isEmpty ? null : _emailErrorMessage,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      errorText: _passwordErrorMessage.isNotEmpty
                          ? _passwordErrorMessage
                          : null,
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isRegisterButtonEnabled
                        ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                        : null,
                    child: Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "These are the terms and conditions of FirstTalk.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

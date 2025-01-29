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

// Splash screen
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
              height: 75,
              width: 75,
            ),
            SizedBox(height: 20),
            Text(
              "FirstTalk",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Gradient background
class GradientBackground extends StatelessWidget {
  final Widget child;

  GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orangeAccent, Colors.amberAccent],
        ),
      ),
      child: child,
    );
  }
}

// Login page
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
    r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$',
  );

  void _updateLoginButtonState() {
    setState(() {
      bool isEmailValid = emailRegExp.hasMatch(_emailController.text);
      _emailErrorMessage =
          isEmailValid ? "" : "Please enter a valid email address.";
      _isLoginButtonEnabled =
          isEmailValid && _passwordController.text.length >= 6;
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
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset("assets/first.jpg"),
                    height: 75,
                    width: 75,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "FirstTalk",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      errorText: _emailErrorMessage.isEmpty
                          ? null
                          : _emailErrorMessage,
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
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                              MaterialPageRoute(
                                  builder: (context) => TermsPage()),
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
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    child: Text("New to FirstTalk? Register here"),
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

// Forgot password page
class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isResetButtonEnabled = false;
  String _emailErrorMessage = "";

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Update the button state based on email validation
  void _updateResetButtonState() {
    setState(() {
      bool isEmailValid = emailRegExp.hasMatch(_emailController.text);
      _emailErrorMessage =
          isEmailValid ? "" : "Please enter a valid email address.";
      _isResetButtonEnabled = isEmailValid;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateResetButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FirstTalk",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: GradientBackground(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Reset Your Password",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                        errorText: _emailErrorMessage.isEmpty
                            ? null
                            : _emailErrorMessage,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isResetButtonEnabled
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Password reset link sent to your email!"),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text("Reset Password"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Registration page
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
  String _passwordInstructionMessage = "";

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$',
  );

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
  );

  void _updateRegisterButtonState() {
    setState(() {
      bool isEmailValid = emailRegExp.hasMatch(_emailController.text);
      _emailErrorMessage =
          isEmailValid ? "" : "Please enter a valid email address.";

      bool isPasswordValid = passwordRegExp.hasMatch(_passwordController.text);
      _passwordErrorMessage = isPasswordValid ? "" : "Follow instructions";

      _passwordInstructionMessage = _passwordController.text.isEmpty
          ? "Password must be 8 characters long, contain:\n1 digit, 1 uppercase letter, 1 special character."
          : (isPasswordValid
              ? ""
              : "Password must be 8 characters long, contain:\n1 digit, 1 uppercase letter, 1 special character.");

      _isRegisterButtonEnabled = _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          isEmailValid &&
          isPasswordValid;
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
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset("assets/first.jpg"),
                    height: 75,
                    width: 75,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "FirstTalk",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
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
                      errorText: _emailErrorMessage.isEmpty
                          ? null
                          : _emailErrorMessage,
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
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                  SizedBox(height: 10),
                  // Display password instruction only if password is invalid or empty
                  if (_passwordInstructionMessage.isNotEmpty)
                    Text(
                      _passwordInstructionMessage,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isRegisterButtonEnabled
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          }
                        : null,
                    child: Text("Register"),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Already have an account? Login here"),
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

//terms and conditions
class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent, centerTitle: true, // AppBar color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "These are the terms and conditions of FirstTalk.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30), // Space between the text and the button
              ElevatedButton(
                onPressed: () {
                  // Action when the "Agree" button is pressed
                  Navigator.pop(
                      context); // You can navigate to any other page here
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.orangeAccent),
                  // Button color (orange accent)
                  padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
                  // Padding for the button
                  textStyle: WidgetStateProperty.all(TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold)), // Text style for the button
                ),
                child: Text(
                  "Agree",
                  style: TextStyle(color: Colors.black),
                ), // Button text
              ),
            ],
          ),
        ),
      ),
    );
  }
}

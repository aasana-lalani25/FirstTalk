import 'dart:convert';
import 'package:flutter/material.dart';
import 'courses.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

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
    r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$',
  );

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

  void _updateLoginButtonState() {
    setState(() {
      String email = _emailController.text.trim();
      bool isEmailValid = emailRegExp.hasMatch(email);

      if (email.isEmpty) {
        _emailErrorMessage = "This field cannot be empty.";
      } else if (!isEmailValid) {
        _emailErrorMessage = "Enter a valid email (Gmail/Yahoo).";
      } else {
        _emailErrorMessage = "";
      }

      _isLoginButtonEnabled =
          isEmailValid && _passwordController.text.length >= 6;
    });
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("OK")),
        ],
      ),
    );
  }

  Future<void> _loginUser() async {
    final uri = Uri.parse("http://192.168.1.70/backend/login_user.php");
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showAlert(context, "Error", "Please fill in all fields.");
      return;
    }

    try {
      var res = await http.post(uri, body: {
        "email": email,
        "password": password,
      });

      print("Login Response: ${res.body}");

      if (res.statusCode == 200 && res.body.isNotEmpty) {
        var response = jsonDecode(res.body);

        if (response["success"] == true) {
          String name = response["user"]["name"];
          // Redirect to the HomePage after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(userName: name), // Change CoursesPage to HomePage
            ),
          );
        } else {
          _showAlert(context, "Login Failed",
              response["error"] ?? "Incorrect email or password.");
        }
      } else {
        _showAlert(context, "Server Error", "Unexpected server response.");
      }
    } catch (e) {
      _showAlert(context, "Error", "Network error: $e");
    }
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/first.jpg", height: 75, width: 75),
                  SizedBox(height: 0),
                  Text("FirstTalk",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(height: 150),
                  Text("Login",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
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
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor:
                      _isLoginButtonEnabled ? Colors.white : Colors.grey,
                    ),
                    onPressed: _isLoginButtonEnabled ? _loginUser : null,
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
    r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$',
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
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                        ),
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
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isRegisterButtonEnabled = false;
  bool _isPasswordVisible = false;
  String _contactErrorMessage = "";
  String _passwordErrorMessage = "";
  String _passwordInstructionMessage = "";

  Future<void> insertrecord() async {
    if (_nameController.text.isNotEmpty &&
        _contactController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      try {
        String password = _passwordController.text.trim();

        String uri = "http://192.168.1.70/backend/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": _nameController.text.trim(),
          "email": _contactController.text.trim(),
          "password": password,
        });

        print("Response body: ${res.body}");

        if (res.statusCode == 200 && res.body.isNotEmpty) {
          var response = jsonDecode(res.body);

          if (response["success"] == true || response["success"] == "true") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration successful!")),
            );
          } else {
            String error = response["error"] ?? "Unknown error";
            if (error.contains("already a user")) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("User Exists"),
                  content: Text("You are already a user, please login."),
                  actions: [
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: $error")),
              );
            }
          }
        } else {
          print("Server error: ${res.statusCode}");
        }
      } catch (e) {
        print("Exception: $e");
      }
    } else {
      print("Please fill all fields");
    }
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$',
  );

  final RegExp phoneRegExp = RegExp(
    r'^\d{10}$',
  );

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
  );

  void _updateRegisterButtonState() {
    setState(() {
      bool isEmailValid = emailRegExp.hasMatch(_contactController.text);
      bool isPhoneValid = phoneRegExp.hasMatch(_contactController.text);
      _contactErrorMessage = (isEmailValid || isPhoneValid)
          ? ""
          : "Enter a valid Email or Phone Number.";

      bool isPasswordValid = passwordRegExp.hasMatch(_passwordController.text);
      _passwordErrorMessage = isPasswordValid ? "" : "Follow instructions";

      _passwordInstructionMessage = _passwordController.text.isEmpty
          ? "Password must be 8 characters long, contain:\n1 digit, 1 uppercase letter, 1 special character."
          : (isPasswordValid
          ? ""
          : "Password must be 8 characters long, contain:\n1 digit, 1 uppercase letter, 1 special character.");

      _isRegisterButtonEnabled = _nameController.text.isNotEmpty &&
          _contactController.text.isNotEmpty &&
          (isEmailValid || isPhoneValid) &&
          isPasswordValid;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateRegisterButtonState);
    _contactController.addListener(_updateRegisterButtonState);
    _passwordController.addListener(_updateRegisterButtonState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
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
                  SizedBox(height: 0),
                  Text(
                    "FirstTalk",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 150),
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _contactController,
                    decoration: InputDecoration(
                      labelText: "Phone No/Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white,
                      filled: true,
                      errorText: _contactErrorMessage.isEmpty
                          ? null
                          : _contactErrorMessage,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
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
                  // Inside the RegistrationPage widget
                  ElevatedButton(
                    onPressed: _isRegisterButtonEnabled
                        ? () {
                      insertrecord();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpVerificationPage(
                              userContact: _otpController.text),
                        ),
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
class TermsPage extends StatefulWidget {
  final String userName; // Accept name as a parameter

  // Constructor to pass name to TermsPage
  TermsPage({required this.userName});

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool isChecked = false; // Checkbox state

  void toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value ?? false; // Toggle the checkbox value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true, // AppBar color
      ),
      body: SingleChildScrollView(
        // Make the body scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome to FirstTalk, a revolutionary platform designed to record and interpret gestures for the deaf and hard-of-hearing community. "
                    "By using our app, you agree to be bound by these Terms and Conditions, which govern your access to and use of FirstTalk.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Terms of Use",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Eligibility: The App is intended for individuals aged 13 and above. By using the App, you represent and warrant that you meet this eligibility requirement.\n\n"
                    "2. User Account: You may be required to create a user account to access certain features of the App. You agree to provide accurate and complete information during the registration process.\n\n"
                    "3. Gesture Data: By using the App, you consent to the recording and interpretation of your gestures. You acknowledge that the App may store and process your Gesture Data to provide the services.\n\n"
                    "4. Prohibited Use: You agree not to use the App for any unlawful or unauthorized purposes, including but not limited to:\n"
                    "- Harassing or intimidating others\n"
                    "- Posting or sharing explicit or offensive content\n"
                    "- Infringing on intellectual property rights\n",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Collection of Gesture Data: The App collects Gesture Data to provide the services. We may store and process this data to improve the App's performance and functionality.\n\n"
                    "2. Use of Gesture Data: We may use Gesture Data for the following purposes:\n"
                    "- To provide the services and improve the App's functionality\n"
                    "- To develop new features and services\n"
                    "- To analyze usage patterns and improve the user experience\n\n"
                    "3. Sharing of Gesture Data: We may share Gesture Data with third-party service providers to improve the App's functionality and performance. We will not share Gesture Data with any third party for marketing or advertising purposes.\n\n"
                    "4. Data Security: We implement reasonable security measures to protect Gesture Data from unauthorized access, disclosure, or destruction.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Changes to Terms and Conditions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We reserve the right to modify or update these Terms and Conditions at any time. Your continued use of the App shall constitute your acceptance of any changes.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Acknowledgement",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "By using FirstTalk, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Checkbox for accepting terms
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: toggleCheckbox,
                  ),
                  Expanded(
                    child: Text(
                      "I accept the Terms and Conditions",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30), // Space between the checkbox and the button

              // Agree Button - enabled only if checkbox is checked
              ElevatedButton(
                onPressed: isChecked
                    ? () {
                  // Action when the "Agree" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userName:
                        widget.userName, // Pass the user name here
                      ),
                    ),
                  );
                }
                    : null, // Disable the button if the checkbox is not checked
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.orangeAccent),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
                  textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold)), // Text style for the button
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Agree",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ), // Button text
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//OTP VERIFICATION

class OtpVerificationPage extends StatefulWidget {
  final String userContact;

  OtpVerificationPage({required this.userContact});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  String _errorMessage = "";
  final String _correctOtp = "1234"; // Hardcoded OTP for now

  void _verifyOtp() {
    if (_otpController.text == _correctOtp) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TermsPage(userName: "User"),
        ),
      );
    } else {
      setState(() {
        _errorMessage = "Invalid OTP. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "OTP Verification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Enter the 4-digit OTP sent to ${widget.userContact}",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Enter OTP",
                      errorText: _errorMessage.isEmpty ? null : _errorMessage,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    child: Text(
                      "Submit",
                      style: TextStyle(fontWeight: FontWeight.bold),
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

import 'package:first_talk/home.dart';
import 'package:first_talk/main.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  String? _selectedGender;
  String? _selectedHardOfHearing;
  TextEditingController emailController = TextEditingController();
  TextEditingController recoveryEmailController = TextEditingController();
  TextEditingController dobController =
      TextEditingController(); // Controller for Date of Birth
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  // Helper function to check if all fields are filled
  bool _isFormValid() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        recoveryEmailController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        _selectedGender != null &&
        areaController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty;
  }

  // Helper function to validate email format
  bool _isValidEmail(String email) {
    final emailRegEx =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegEx.hasMatch(email);
  }

  // Helper function to validate pincode (only digits, and length 6)
  bool _isValidPincode(String pincode) {
    final pincodeRegEx = RegExp(r'^[0-9]{6}$');
    return pincodeRegEx.hasMatch(pincode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Details",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Edit Profile Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              _buildTextField("Name", nameController),
              _buildEmailTextField(),
              _buildTextField("Recovery Email", recoveryEmailController),
              _buildDateOfBirthField(), // Date of Birth field
              _buildGenderRadioButton(),
              _buildAddressFields(),
              _buildHardOfHearingRadioButton(),
              _buildTextField("Bio/Short Description", TextEditingController()),
              SizedBox(height: 20), // Space before Save button
              _buildSaveButton(),
              SizedBox(height: 10), // Space before Logout button
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create text fields
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // Helper function to create the Email TextField with validation
  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // Helper function to create the Date of Birth TextField
  Widget _buildDateOfBirthField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: dobController,
        decoration: InputDecoration(
          labelText: "Date of Birth",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        readOnly: true,
        // Make the text field readonly so it doesn't show a keyboard
        onTap: () => _selectDate(context), // Open the date picker when tapped
      ),
    );
  }

  // Date picker method
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        dobController.text = "${picked.toLocal()}"
            .split(' ')[0]; // Format the date to YYYY-MM-DD
      });
    }
  }

  // Helper function to create radio buttons for gender selection
  Widget _buildGenderRadioButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gender",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              Radio<String>(
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Male'),
              Radio<String>(
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Female'),
              Radio<String>(
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (String? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Other'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to create radio buttons for "Hard of Hearing" selection
  Widget _buildHardOfHearingRadioButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hard of Hearing",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: <Widget>[
              Radio<String>(
                value: 'Yes',
                groupValue: _selectedHardOfHearing,
                onChanged: (String? value) {
                  setState(() {
                    _selectedHardOfHearing = value;
                  });
                },
              ),
              Text('Yes'),
              Radio<String>(
                value: 'No',
                groupValue: _selectedHardOfHearing,
                onChanged: (String? value) {
                  setState(() {
                    _selectedHardOfHearing = value;
                  });
                },
              ),
              Text('No'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to create address fields (City, State, Country, Pincode)
  Widget _buildAddressFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          _buildTextField("Area", areaController),
          _buildTextField("City", cityController),
          _buildTextField("State", stateController),
          _buildTextField("Country", countryController),
          _buildTextField("Pincode", pincodeController),
        ],
      ),
    );
  }

  // Helper function to create the Save button
  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isFormValid()
            ? () {
                // Validate email and recovery email format
                if (!_isValidEmail(emailController.text)) {
                  _showErrorDialog("Invalid email format.");
                } else if (!_isValidEmail(recoveryEmailController.text)) {
                  _showErrorDialog("Invalid recovery email format.");
                } else if (!_isValidPincode(pincodeController.text)) {
                  _showErrorDialog(
                      "Invalid pincode. It should be a 6-digit number.");
                } else if (emailController.text ==
                    recoveryEmailController.text) {
                  _showErrorDialog(
                      "Email and Recovery Email cannot be the same.");
                } else {
                  // Handle saving logic here
                  _showSuccessDialog("Profile saved successfully.");
                }
              }
            : null, // Disable button if form is not valid
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          "Save",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  // Helper function to create the Logout button
  Widget _buildLogoutButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          "Logout",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  // Show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Show a success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Success"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          userName: '',
                        )), // Correct navigation here
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}



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
  String _selectedCountryCode = '+91'; // Default country code
  TextEditingController emailController = TextEditingController();
  TextEditingController recoveryEmailController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController dobController = TextEditingController(); // Controller for Date of Birth
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  // Helper function to check if all fields are filled
  bool _isFormValid() {
    bool isValid = firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        recoveryEmailController.text.isNotEmpty &&
        phonenoController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        _selectedGender != null &&
        houseNoController.text.isNotEmpty &&
        areaController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty;

    print("Form Valid: $isValid"); // Debugging statement
    return isValid;
  }

  // Updated function to validate phone number format
  bool _isvalidPhoneNo(String phone) {
    final phoneRegEx = RegExp(r'^[0-9]{10}$'); // Ensures exactly 10 digits
    return phoneRegEx.hasMatch(phone);
  }


  // Helper function to validate email format
  bool _isValidEmail(String email) {
    final emailRegEx = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$',
    );
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
              _buildTextField("First Name", firstnameController, Icons.person),
              _buildTextField("Last Name", lastnameController, Icons.person),
              _buildEmailTextField(),
              _buildRecoveryEmailTextField(),
              _buildPhoneNoTextField(),
              _buildDateOfBirthField(context), // Date of Birth field
              _buildGenderRadioButton(),
              _buildAddressFields(),
              _buildHardOfHearingRadioButton(),
              _buildTextField(
                  "Bio/Short Description", TextEditingController(), Icons.edit),
              SizedBox(height: 20), // Space before Save button
              _buildSaveButton(),
              SizedBox(height: 10), // Space before Logout button
              _buildLogoutButton(),
              SizedBox(height: 10), // Space before Delete Account button
              _buildDeleteAccountButton(), // Delete Account button
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create text fields with icons
  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // Helper function to create the Email TextField with validation and icon
  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Email",
          prefixIcon: Icon(Icons.email, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  // Helper function to create the Recovery Email TextField with validation and icon
  Widget _buildRecoveryEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: recoveryEmailController,
        decoration: InputDecoration(
          labelText: "Recovery Email",
          prefixIcon: Icon(Icons.email, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          errorText: emailController.text == recoveryEmailController.text
              ? 'Email and Recovery Email cannot be the same'
              : null, // Show error if both emails are the same
        ),
      ),
    );
  }


  Widget _buildPhoneNoTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: _selectedCountryCode,
              items: ['+91', '+1', '+44', '+61', '+81'].map((code) {
                return DropdownMenuItem(
                  value: code,
                  child: Text(code),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountryCode = value!;
                });
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: phonenoController,
              decoration: InputDecoration(
                labelText: "Phone No",
                prefixIcon: Icon(Icons.phone, color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: _isvalidPhoneNo(phonenoController.text) ? null : 'Enter a valid phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create the Date of Birth TextField with icon
  Widget _buildDateOfBirthField(BuildContext context) { // Pass context explicitly
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: dobController,
        decoration: InputDecoration(
          labelText: "Date of Birth",
          prefixIcon: Icon(Icons.calendar_today, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        readOnly: true,
        onTap: () => _selectDate(context), // Pass context when calling function
      ),
    );
  }

// Date picker method
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = dobController.text.isNotEmpty
        ? DateTime.parse(dobController.text) // Use existing date if available
        : DateTime.now();

    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day.toString().padLeft(2, '0')}-"
            "${picked.month.toString().padLeft(2, '0')}-"
            "${picked.year}"; // Format as DD-MM-YYYY
      });
    }
  }

  // Helper function to create radio buttons for gender selection with icons
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
              Icon(Icons.male, color: Colors.black),
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
              Icon(Icons.female, color: Colors.black),
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
              Icon(Icons.transgender, color: Colors.black),
              Text('Other'),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to create radio buttons for "Hard of Hearing" selection with icon on the left
  Widget _buildHardOfHearingRadioButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hearing, color: Colors.black),
              SizedBox(width: 6), // Space between icon and label
              Text("Hard of Hearing",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
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
              SizedBox(width: 30), // Space between options
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

  // Helper function to create address fields (City, State, Country, Pincode) with icons
  Widget _buildAddressFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          _buildTextField("House No, Building, Society", houseNoController, Icons.home),
          _buildTextField("Area", areaController, Icons.location_on),
          _buildTextField("City", cityController, Icons.location_city),
          _buildTextField("State", stateController, Icons.map),
          _buildTextField("Country", countryController, Icons.public),
          _buildTextField("Pincode", pincodeController, Icons.pin),
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
          _showLogoutConfirmationDialog();
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
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Navigate to LoginPage after confirming logout
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false, // Remove all previous routes
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Helper function to create the Delete Account button
  Widget _buildDeleteAccountButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showDeleteConfirmationDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: Size(double.infinity, 50),
        ),
        child: Text(
          "Delete Account",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  // Show confirmation dialog for deleting the account
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Account"),
        content: Text("Are you sure you want to delete the account?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Navigate to Registration page when user confirms
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RegistrationPage()),
                    (Route<dynamic> route) => false, // Remove all routes
              );
            },
            child: Text("OK"),
          ),
        ],
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
                      ))); // Navigate to HomePage after saving
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
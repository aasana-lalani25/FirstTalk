import 'package:first_talk/home.dart';
import 'package:first_talk/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController dobController =
      TextEditingController(); // Controller for Date of Birth
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController bioController = TextEditingController();

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
                  "Bio/Short Description", bioController, Icons.edit),
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

  // Helper function to create the Phone No TextField with validation
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorText: _isvalidPhoneNo(phonenoController.text)
                    ? null
                    : 'Enter a valid phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create the Date of Birth TextField with icon
  Widget _buildDateOfBirthField(BuildContext context) {
    // Pass context explicitly
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
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Male'),
              Radio<String>(
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              Text('Female'),
              Radio<String>(
                value: 'Other',
                groupValue: _selectedGender,
                onChanged: (value) {
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

  // Helper function to create radio buttons for Hard of Hearing selection
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
                onChanged: (value) {
                  setState(() {
                    _selectedHardOfHearing = value;
                  });
                },
              ),
              Text('Yes'),
              Radio<String>(
                value: 'No',
                groupValue: _selectedHardOfHearing,
                onChanged: (value) {
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

  // Helper function to create address fields
  Widget _buildAddressFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField("House No", houseNoController, Icons.home),
          _buildTextField("Area", areaController, Icons.location_on),
          _buildTextField("City", cityController, Icons.location_city),
          _buildTextField("State", stateController, Icons.location_on),
          _buildTextField("Country", countryController, Icons.flag),
          _buildTextField("Pincode", pincodeController, Icons.pin),
        ],
      ),
    );
  }

  // Save button function
  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _isFormValid()
          ? () {
              // Save profile data and navigate to HomePage
              _saveProfile();
            }
          : null,
      child: Text(
        'Save Profile',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }

  // Logout button function
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

  // Delete account button function
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

  // Profile data save function (replace with your actual logic)
  void _saveProfile() async {
    if (_isFormValid()) {
      // Prepare the data to be sent to the backend
      var data = {
        "first_name": firstnameController.text,
        "last_name": lastnameController.text,
        "email": emailController.text,
        "recovery_email": recoveryEmailController.text,
        "phone_no": phonenoController.text,
        "dob": dobController.text,
        "gender": _selectedGender,
        "bio": bioController.text,
        "house_no": houseNoController.text,
        "area": areaController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "pincode": pincodeController.text,
        "hard_of_hearing": _selectedHardOfHearing,
      };

      try {
        // Make the POST request to your backend
        final response = await http.post(
          Uri.parse('http://192.168.1.70/backend/save_profile.php'),
          // Replace with your actual URL
          headers: {
            'Content-Type': 'application/json',
            // Ensure the request is JSON formatted
          },
          body: json.encode(data), // Convert data to JSON
        );

        // Check if the response is successful (status code 200)
        if (response.statusCode == 200) {
          // If the server returns a 200 response, the profile was saved
          print("Profile saved successfully.");
          // Optionally, you can navigate to another screen or show a success message
        } else {
          // If the server did not return a 200 status, handle the error
          print("Failed to save profile. Error: ${response.statusCode}");
        }
      } catch (e) {
        // Handle errors, e.g., network issues or server errors
        print("Error saving profile: $e");
      }
    } else {
      print("Please fill all the required fields.");
    }
  }
}

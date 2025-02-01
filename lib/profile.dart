import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  String? _selectedGender;
  String? _selectedHardOfHearing;

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
            Text("Edit Profile Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            _buildTextField("Name"),
            _buildTextField("Email"),
            _buildTextField("Recovery Email"),
            _buildTextField("Date of Birth"),
            _buildGenderRadioButton(),
            _buildTextField("Address"),
            _buildHardOfHearingRadioButton(), // Updated for Hard of Hearing
            _buildTextField("Bio/Short Description"),
            SizedBox(height: 40), // Space before Logout button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout logic
                  Navigator.pop(context);
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
            ),
          ],
        ),
      ),
    )
    );
  }

  // Helper function to create text fields
  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  // Helper function to create radio buttons for gender selection
  Widget _buildGenderRadioButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          Text("Hard of Hearing", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
}

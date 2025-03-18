import 'package:flutter/material.dart';

class PersonalDetailPage extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentEmail;
  final String currentDob;
  final String currentGender;

  const PersonalDetailPage({
    Key? key,
    required this.currentName,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentDob,
    required this.currentGender,
  }) : super(key: key);

  @override
  _PersonalDetailPageState createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _emailController = TextEditingController(text: widget.currentEmail);
    _dobController = TextEditingController(text: widget.currentDob);
    _genderController = TextEditingController(text: widget.currentGender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Background
      appBar: AppBar(
        title: const Text("Edit Personal Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(_nameController, "Name"),
            _buildTextField(_phoneController, "Phone Number"),
            _buildTextField(_emailController, "Email"), // Added Email
            _buildTextField(_dobController, "Date of Birth"),
            _buildTextField(_genderController, "Gender"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'phone': _phoneController.text,
                  'email': _emailController.text, // Return updated email
                  'dob': _dobController.text,
                  'gender': _genderController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

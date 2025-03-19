import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class PersonalDetailPage extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentEmail;
  final String currentDob;
  final String currentGender;

  const PersonalDetailPage({
    super.key,
    required this.currentName,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentDob,
    required this.currentGender,
  });

  @override
  _PersonalDetailPageState createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  String? _selectedGender;
  DateTime? _selectedDob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _emailController = TextEditingController(text: widget.currentEmail);
    _selectedGender = widget.currentGender.isNotEmpty ? widget.currentGender : null;
    _selectedDob = widget.currentDob.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(widget.currentDob) : null;
  }

  // Function to Show Date Picker
  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), 
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDob) {
      setState(() {
        _selectedDob = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        title: const Text("Edit Personal Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black, 
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white), 
                decoration: _inputDecoration("Name"),
                validator: (value) => value!.isEmpty ? "Name cannot be empty" : null,
              ),
              const SizedBox(height: 15),

              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Phone number cannot be empty" : null,
              ),
              const SizedBox(height: 15),

              // Email Field
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Email cannot be empty" : null,
              ),
              const SizedBox(height: 15),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _selectedGender,
                dropdownColor: Colors.black, 
                style: const TextStyle(color: Colors.white), 
                decoration: _inputDecoration("Gender"),
                items: ["Male", "Female", "Other"].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) => value == null ? "Please select a gender" : null,
              ),
              const SizedBox(height: 15),

              // Date of Birth Picker
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: _selectedDob != null ? DateFormat('yyyy-MM-dd').format(_selectedDob!) : "",
                ),
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Date of Birth").copyWith(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    onPressed: () => _pickDate(context),
                  ),
                ),
                onTap: () => _pickDate(context),
                validator: (value) => value!.isEmpty ? "Please select your Date of Birth" : null,
              ),
              const SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'email': _emailController.text,
                      'gender': _selectedGender ?? "",
                      'dob': _selectedDob != null ? DateFormat('yyyy-MM-dd').format(_selectedDob!) : "",
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  foregroundColor: Colors.black, 
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Input Decoration for Consistency
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70), 
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white70), 
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white), 
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

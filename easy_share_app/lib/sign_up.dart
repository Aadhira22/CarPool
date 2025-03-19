import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text('Full Name',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                TextFormField(
                    decoration:
                        InputDecoration(border: UnderlineInputBorder())),
                SizedBox(height: 20),
                Text('Gender',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(),
                  items: ['Male', 'Female', 'Other']
                      .map((label) =>
                          DropdownMenuItem(value: label, child: Text(label)))
                      .toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                Text('Mobile Number',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset(
                      'assets/national_flag.jpg',
                      width: 24,
                      height: 16,
                    ),
                    SizedBox(width: 8),
                    DropdownButton<String>(
                      value: '+91',
                      items: [
                        DropdownMenuItem(value: '+91', child: Text('+91'))
                      ],
                      onChanged: (value) {},
                      underline: SizedBox(),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _mobileNumberController,
                        decoration:
                            InputDecoration(border: UnderlineInputBorder()),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Email',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                TextFormField(
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 20),
                Text('Password',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                ),
                SizedBox(height: 20),
                Text('Confirm Password',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: _validateConfirmPassword,
                ),
                SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Continue',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

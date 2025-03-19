import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Personal_detail.dart';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "John Doe";
  String phoneNumber = "123-456-7890"; // Default phone number
  File? _profileImage;

  // Function to Pick Image
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Background
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture with Edit Option
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor:
                        Colors.grey[800], // Black Circle Background
                    child: _profileImage != null
                        ? ClipOval(
                            child: Image.file(
                              _profileImage!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                        : const Icon(
                            Icons.person, // Black Avatar Icon
                            color: Colors.black,
                            size: 50,
                          ),
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor:
                        Colors.black, // Black Camera Icon Background
                    child: Icon(Icons.camera_alt,
                        color: Colors.white, size: 18), // White Camera Icon
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Text(name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(phoneNumber,
                style: const TextStyle(fontSize: 16, color: Colors.white70)),

            const SizedBox(height: 30),

            // Profile Options
            _buildProfileOption(Icons.person, "Personal Details", context,
                isPersonal: true),
            _buildProfileOption(Icons.payment, "Payment", context),
            _buildProfileOption(Icons.help, "Help", context),
            _buildProfileOption(Icons.settings, "Settings", context),
            _buildProfileOption(Icons.logout, "Logout", context,
                isLogout: true),
          ],
        ),
      ),
    );
  }

  // Function to Build Profile Options
  Widget _buildProfileOption(IconData icon, String title, BuildContext context,
      {bool isLogout = false, bool isPersonal = false}) {
    return GestureDetector(
      onTap: () {
        if (isPersonal) {
          // Navigate to Personal Details Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalDetailPage(
                currentName: name,
                currentPhone: phoneNumber,
                currentEmail: '', // Can be updated
                currentDob: '',
                currentGender: '',
              ),
            ),
          ).then((updatedDetails) {
            if (updatedDetails != null) {
              setState(() {
                name = updatedDetails['name'];
                phoneNumber = updatedDetails['phone'];
              });
            }
          });
        } else if (isLogout) {
          _logout(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[900], // Dark Grey Background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Navigate to Login Page and remove all previous pages
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false, // Removes all previous routes
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

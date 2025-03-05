import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/profile_picture.png"),
          ),
          SizedBox(height: 10),
          Text(
            "John Doe",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("john.doe@example.com"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: Colors.amber,
              );
            }),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildListTile(Icons.person, "Personal Details", context),
                _buildListTile(Icons.payment, "Payment", context),
                _buildListTile(Icons.help, "Help", context),
                _buildListTile(Icons.settings, "Settings", context),
                _buildListTile(Icons.logout, "Logout", context, isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, BuildContext context, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
      title: Text(title, style: TextStyle(color: isLogout ? Colors.red : Colors.black)),
      onTap: () {
      },
    );
  }
}

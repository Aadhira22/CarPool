import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'), // Profile image
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'John Doe',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'johndoe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            _buildInfoTile(Icons.phone, 'Phone', '+1 123 456 7890'),
            _buildInfoTile(Icons.directions_car, 'Car Model', 'Toyota Corolla'),
            _buildInfoTile(Icons.confirmation_number, 'License Plate', 'XYZ-1234'),
            SizedBox(height: 20),
            Text(
              'Ride History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildRideHistory('Home to Office', 'Completed', '₹150'),
            _buildRideHistory('City Mall to Downtown', 'Pending', '₹200'),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildRideHistory(String route, String status, String fare) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.history, color: Colors.green),
        title: Text(route),
        subtitle: Text('Status: $status'),
        trailing: Text(fare, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

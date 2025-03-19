import 'package:flutter/material.dart';

class CarpoolGroupScreen extends StatelessWidget {
  final String groupName;
  final String groupImage;
  final int membersCount;
  final String groupType;
  final List<Map<String, String>> upcomingRides;

  const CarpoolGroupScreen({
    super.key,
    required this.groupName,
    required this.groupImage,
    required this.membersCount,
    required this.groupType,
    required this.upcomingRides,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carpool group"),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () {
              // Handle invite action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(groupImage),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    groupName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$membersCount members",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    groupType,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle leave group action
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[200],
                    ),
                    child: const Text("Leave group"),
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "About",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Members",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Settings",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    "We're a small group of friends who share rides...",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Upcoming rides",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...upcomingRides.map((ride) => RideTile(
                        imageUrl: ride['imageUrl']!,
                        date: ride['date']!,
                        route: ride['route']!,
                      )),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle join group action
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Join this group"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideTile extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String route;

  const RideTile({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        date,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(route),
    );
  }
}

import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'car_group_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<Map<String, String>> chats = [
    {
      "name": "User 1",
      "message": "Where are you?",
      "avatar": "assets/woman1.jpg",
      "type": "individual"
    },
    {
      "name": "User 2",
      "message": "I'm about to reach.",
      "avatar": "assets/woman1.jpg",
      "type": "individual"
    },
    {
      "name": "User 3",
      "message": "Let's meet at the corner.",
      "avatar": "assets/woman1.jpg",
      "type": "individual"
    },
    {
      "name": "Car pool in Delhi",
      "message": "Mr. Singh: Shared an invite for the upcoming carpool!",
      "avatar": "assets/woman.jpg",
      "type": "group"
    },
    {
      "name": "Travel Buddies",
      "message": "Ms. Sharma: Anybody interested in a weekend getaway?",
      "avatar": "assets/boy1.jpg",
      "type": "group"
    }
  ];

  void createGroup() {
    // Show dialog to input group name
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Group Name'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Group Name',
            ),
            onSubmitted: (groupName) {
              if (groupName.isNotEmpty) {
                setState(() {
                  chats.add({
                    "name": groupName,
                    "message": "Group created!",
                    "avatar": "https://source.unsplash.com/50x50/?group",
                    "type": "group"
                  });
                });
                Navigator.pop(context); // Close the dialog
              }
            },
          ),
        );
      },
    );
  }

  void openChat(Map<String, String> chat) {
    if (chat["type"] == "group") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarpoolGroupScreen(
            groupName: chat["name"]!,
            groupImage: chat["avatar"]!,
            membersCount: 2, // Example count, you can make it dynamic
            groupType: "Private group", // Example type, you can make it dynamic
            upcomingRides: [
              {
                'imageUrl': 'assets/city.jpg',
                'date': 'Tue, Jan 11, 8:00 AM',
                'route': 'Delhi to Haryana',
              },
              {
                'imageUrl': 'assets/city.jpg',
                'date': 'Fri, Jan 14, 6:00 PM',
                'route': 'Rajasthan to Telangana',
              },
              {
                'imageUrl': 'assets/city.jpg',
                'date': 'Sun, Jan 16, 8:00 AM',
                'route': 'Delhi to Mumbai',
              },
            ],
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(chatName: chat["name"]!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            iconSize: 30.0, // Explicitly set icon size
            onPressed: createGroup,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                var chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chat["avatar"]!),
                  ),
                  title: Text(
                    chat["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chat["message"]!),
                  onTap: () => openChat(chat),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

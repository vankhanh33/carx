import 'package:carx/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalView extends StatefulWidget {
  const PersonalView({super.key});

  @override
  State<PersonalView> createState() => _PersonalViewState();
}

class _PersonalViewState extends State<PersonalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(child: Text('Edit profile')),
                PopupMenuItem(child: Text('Log out')),
              ];
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserAvatar(
                      size: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Center(
              child: Text(
                'Khanh Super Car',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Colors.black26),
            const SizedBox(height: 16),
            SizedBox(
              height: items.length * 50,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {});
                    },
                    leading: Icon(items[index]["icon"]),
                    title: Text(items[index]["text"]),
                    trailing: const Icon(Icons.arrow_right),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

const List<Map<String, dynamic>> items = [
  {"icon": Icons.person, "text": "Edit Profile"},
  {"icon": Icons.card_travel, "text": "My Cart"},
  {"icon": Icons.car_rental, "text": "Rent A Car"},
  {"icon": Icons.location_on_outlined, "text": "Address"},
  {"icon": Icons.notifications, "text": "Notification"},
  {"icon": Icons.payment_outlined, "text": "Payment"},
  {"icon": Icons.admin_panel_settings_outlined, "text": "Security"},
  {"icon": Icons.language_rounded, "text": "Languge"},
  {"icon": Icons.airplay_sharp, "text": "Car Rental Instructions"},
  {"icon": Icons.support_agent_outlined, "text": "Support "},
  {"icon": Icons.logout_outlined, "text": "Log Out"},
];

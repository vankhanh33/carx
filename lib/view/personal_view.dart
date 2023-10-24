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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: UserAvatar(
                      size: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Color(0xffe0e3e7),
                          borderRadius: BorderRadius.all(Radius.circular(999))),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        size: 16,
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
              child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final SettingItem item = items[index];
                  return Container(
                    margin: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      onTap: () {
                        // Navigator.of(context).pushNamed(item.route!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border:
                              Border.all(width: 1, color: Color(0xffe0e3e7)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xffe0e3e7),
                            child: SvgPicture.asset(
                              item.icon,
                              color: const Color.fromARGB(255, 129, 129, 129),
                              width: 24,
                            ),
                          ),
                          title: Text(item.title),
                          subtitle: Text(item.subtitle),
                          trailing:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset('assets/svg/logout.svg', width: 24),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xffe3e5e5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final items = [
  SettingItem(
    icon: 'assets/svg/person.svg',
    title: 'Edit Profile',
    subtitle: 'view edit profile user',
    route: '/editProfile',
  ),
  SettingItem(
    icon: 'assets/svg/cube.svg',
    title: 'Order',
    subtitle: 'view all orders',
    route: '/order',
  ),
  SettingItem(
    icon: 'assets/svg/truck.svg',
    title: 'Address',
    subtitle: 'view and manage your address',
    route: '/address',
  ),
  SettingItem(
    icon: 'assets/svg/bell.svg',
    title: 'Notification',
    subtitle: 'view edit profile user',
    route: '/notifications',
  ),
  SettingItem(
    icon: 'assets/svg/payment.svg',
    title: 'Payment',
    subtitle: 'View and manage your payments',
    route: '/payment',
  ),
  SettingItem(
    icon: 'assets/svg/help.svg',
    title: 'Support',
    subtitle: 'view for support',
    route: '/support',
  ),
];

class SettingItem {
  final String icon;
  final String title;
  final String subtitle;
  final String? route;
  SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.route,
  });
}

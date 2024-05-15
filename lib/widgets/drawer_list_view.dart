import 'package:flutter/material.dart';

import '../screens/week_screen.dart';
import 'setting.dart';

class DrawerListView extends StatelessWidget {
  const DrawerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 100,
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          title: const Text('이번주 시간표'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WeekScreen(),
              ),
            );
          },
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          title: const Text('설정'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Setting(),
              ),
            );
          },
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}

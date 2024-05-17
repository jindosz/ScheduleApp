import 'package:flutter/material.dart';

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
            Navigator.popAndPushNamed(context, 'weekScreen');
          },
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          title: const Text('오늘의 시간표'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'todayScreen');
          },
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          title: const Text('설정'),
          onTap: () {
            Navigator.popAndPushNamed(context, 'setting');
          },
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}

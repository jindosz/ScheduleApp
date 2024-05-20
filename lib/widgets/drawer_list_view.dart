import 'package:flutter/material.dart';

class DrawerListView extends StatelessWidget {
  final String screen;

  const DrawerListView({
    super.key,
    required this.screen,
  });

  bool screenIsToday(screen) {
    if (screen == 'todayScreen') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 100,
        ),
        const Divider(
          color: Colors.white,
        ),
        screenIsToday(screen)
            ? ListTile(
                title: const Text(
                  '이번주 시간표',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'weekScreen');
                },
              )
            : ListTile(
                title: const Text(
                  '오늘의 시간표',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'todayScreen');
                },
              ),
        const Divider(
          color: Colors.white,
        ),
        ListTile(
          title: const Text(
            '설정',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, 'setting');
          },
        ),
        const Divider(
          color: Colors.white,
        ),
      ],
    );
  }
}

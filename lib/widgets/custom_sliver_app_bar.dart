import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image.asset('assets/images/ic_yt_logo_dark.png'),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.cast),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          iconSize: 40,
        ),
      ],
    );
  }
}

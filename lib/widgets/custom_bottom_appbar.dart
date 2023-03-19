import 'package:flutter/material.dart';

import '../screens/screens.dart';

class CustomBottomAppbar extends StatelessWidget {
  const CustomBottomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, HomeScreen.routeName);
              },
              icon: const Icon(Icons.home),
              iconSize: 30,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, SearchScreen.routeName);
              },
              icon: const Icon(Icons.search),
              iconSize: 30,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle),
              iconSize: 30,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message),
              iconSize: 30,
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              icon: const Icon(Icons.person),
              iconSize: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

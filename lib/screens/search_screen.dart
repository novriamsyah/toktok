import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toktok/models/user_model.dart';
import 'package:toktok/screens/screens.dart';
import 'package:toktok/widgets/custom_bottom_appbar.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    List<User> users = User.users;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Discover',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: MasonryGridView.count(
        shrinkWrap: true,
        itemCount: users.length,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10.0),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName,
                  arguments: users[index]);
            },
            child: Stack(
              children: [
                Container(
                  height: (index == 0) ? 250 : 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(users[index].imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        stops: [0.4, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(users[index].imagePath),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            users[index].username,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '2 min ago',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppbar(),
    );
  }
}

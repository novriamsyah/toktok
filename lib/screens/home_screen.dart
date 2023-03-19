import 'package:flutter/material.dart';
import 'package:toktok/models/post_model.dart';
import 'package:toktok/widgets/custom_bottom_appbar.dart';
import 'package:toktok/widgets/custom_vidio_player.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = Post.posts;
  @override
  Widget build(BuildContext context) {
    Post? post = ModalRoute.of(context)!.settings.arguments as Post?;
    if (post != null) posts.insert(0, post);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const _CustomAppbar(),
      bottomNavigationBar: const CustomBottomAppbar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: posts.map((post) {
            return CustomVidioPlayer(
              post: post,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(context, 'For You'),
          _buildButton(context, 'Following')
        ],
      ),
    );
  }

  TextButton _buildButton(BuildContext context, String title) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        fixedSize: const Size(100, 50),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

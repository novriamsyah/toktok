import 'package:flutter/material.dart';
import 'package:toktok/models/post_model.dart';
import 'package:toktok/models/user_model.dart';
import 'package:toktok/widgets/custom_bottom_appbar.dart';
import 'package:toktok/widgets/custom_vidio_player_preview.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;
    user = user ??= User.users[0];

    List<Post> posts = Post.posts.where((post) {
      return post.user.id == user!.id;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '@${user.username}',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileInformation(user: user),
            const SizedBox(
              height: 10,
            ),
            _ProfileContent(posts: posts)
          ],
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_view_rounded),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                GridView.builder(
                  itemCount: posts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) {
                    return CustomVidioPlayerPreview(
                      post: posts[index],
                    );
                  },
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInformation extends StatelessWidget {
  final User user;
  const _ProfileInformation({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 103,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(user.imagePath),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 18,
                  child: CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75.0),
          child: Row(
            children: [
              _buildUserInfo(context, 'Following', '${user.followings}'),
              _buildUserInfo(context, 'Followers', '${user.followers}'),
              _buildUserInfo(context, 'Likes', '${user.likes}'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffff006e),
                fixedSize: const Size(200, 50),
              ),
              onPressed: () {},
              child: Text(
                'Follow',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: const Size(50, 50),
              ),
              onPressed: () {},
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Expanded _buildUserInfo(
    BuildContext context,
    String type,
    String value,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            type,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(letterSpacing: 1.5, color: Colors.grey.shade200),
          ),
        ],
      ),
    );
  }
}

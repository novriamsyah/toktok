import 'package:flutter/material.dart';
import 'package:toktok/models/post_model.dart';
import 'package:toktok/widgets/custom_vidio_player.dart';
import 'package:video_player/video_player.dart';

class CustomVidioPlayerPreview extends StatefulWidget {
  final Post post;

  const CustomVidioPlayerPreview({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<CustomVidioPlayerPreview> createState() =>
      _CustomVidioPlayerPreviewState();
}

class _CustomVidioPlayerPreviewState extends State<CustomVidioPlayerPreview> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.asset(widget.post.assetPath);
    controller.initialize().then((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        });
      },
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomVidioPlayer(post: widget.post),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(controller),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '11.9k',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

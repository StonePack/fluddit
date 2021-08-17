import 'package:fluddit/models/index.dart';
import 'package:fluddit/widgets/index.dart';
import 'package:flutter/material.dart';

class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({Key? key, required this.post}) : super(key: key);

  final RedditPost post;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ConditionalWidget(
          condition: post.thumbnail == 'default' ||
              post.thumbnail == 'nsfw' ||
              post.thumbnail == 'spoiler',
          trueWidget: Opacity(
            opacity: .5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink,
                    Colors.pinkAccent,
                    Colors.red,
                    Colors.redAccent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          falseWidget: Container(
            width: 75,
            height: 75,
            child: Opacity(
              opacity: .5,
              child: Image.network(
                post.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Center(
          child: Icon(Icons.play_arrow_outlined),
        ),
      ],
    );
  }
}

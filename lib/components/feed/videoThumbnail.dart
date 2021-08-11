import 'package:fluddit/models/index.dart';
import 'package:fluddit/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoThumbnail extends StatelessWidget {
  const VideoThumbnail({Key? key, required this.post}) : super(key: key);

  final RedditPost post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(
        //   ImageView(src: '${post.imageUrl}'),
        //   transition: Transition.rightToLeft,
        // );
      },
      child: Stack(
        children: [
          ConditionalWidget(
            condition: post.thumbnail != 'default',
            trueWidget: Image.network(
              post.thumbnail,
              fit: BoxFit.cover,
            ),
            falseWidget: Container(),
          ),
          Center(
            child: Icon(Icons.play_arrow_outlined),
          ),
        ],
      ),
    );
  }
}

import 'package:fluddit/bloc/index.dart';
import 'package:fluddit/components/post/content/gallery.content.dart';
import 'package:fluddit/components/post/content/image.content.dart';
import 'package:fluddit/components/post/content/video.content.dart';
import 'package:fluddit/components/post/content/web.content.dart';
import 'package:fluddit/models/index.dart';
import 'package:fluddit/routes/web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({
    Key? key,
    required this.constraints,
    required this.post,
  }) : super(key: key);

  final BoxConstraints constraints;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: getContent(post, constraints),
    );
  }
}

Widget getContent(Post post, BoxConstraints constraints) {
  final ComponentController component = Get.find();

  if (post.isSelf) {
    post.parseUnicode(post.selfText);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: MarkdownBody(
          data: post.parseUnicode(post.selfText),
          onTapLink: (String text, String? url, String other) {
            Get.to(() => WebPage(url: (url ?? '')));
          },
        ),
      ),
    );
  } else if (post.isVideo) {
    return VideoContent(
      constraints: constraints,
      url: post.videoUrl.split('?')[0],
    );
  } else if (component.isImage(post.url) || post.domain == 'imgur.com') {
    return ImageContent(post: post);
  } else if (post.isGallery) {
    return GalleryContent(
      constraints: constraints,
      post: post,
    );
  } else {
    return WebContent(url: '${post.url}');
  }
}

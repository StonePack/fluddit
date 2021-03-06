import 'package:fluddit/bloc/index.dart';
import 'package:fluddit/constants.dart';
import 'package:fluddit/models/index.dart';
import 'package:fluddit/routes/posts.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  PostTile({
    Key? key,
    required this.post,
    required this.posts,
  }) : super(key: key);

  final Posts posts;
  final Post post;

  final ComponentController comp = Get.find();
  final RedditController reddit = Get.find();
  final UserController user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          switch (posts) {
            case Posts.feed:
              reddit.posts = reddit.feedPosts;
              break;
            case Posts.user:
              reddit.posts = user.posts;
              break;
            default:
          }

          final postIndex = reddit.posts.indexOf(post);
          comp.carouselIndex.value = postIndex;

          Get.to(
            () => PostView(post: post),
            transition: Transition.rightToLeft,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            color: Theme.of(context).cardColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    post.getScoreString(),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 125,
                    child: Text(
                      post.title,
                      maxLines: 4,
                      style: TextStyle(
                        color: post.stickied ? Colors.green : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'r/${post.subreddit} | ${post.author}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        post.thumbnail == 'nsfw'
                            ? Text(
                                '[NSFW]',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red[400],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                height: 50,
                width: 50,
                child: comp.getPostThumbnail(post),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

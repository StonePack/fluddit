import 'package:fluddit/bloc/index.dart';
import 'package:fluddit/models/index.dart';
import 'package:fluddit/routes/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostTile extends StatelessWidget {
  PostTile({Key? key, required this.post}) : super(key: key);

  final RedditPost post;

  final RedditController reddit = Get.find();
  final ComponentController comp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: Theme.of(context).cardColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        // Launch the post view
        onTap: () {
          Get.to(
            () => PostView(post: post),
            transition: Transition.rightToLeft,
          );
        },
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 25,
                height: 50,
                child: Center(
                  child: Text(
                    post.getScoreString(),
                  ),
                ),
              ),
              // Post title
              title: Text(
                post.title,
                maxLines: 2,
                style: TextStyle(
                  color: post.stickied ? Colors.green : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              // Thumbnail
              trailing: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                height: 50,
                width: 50,
                child: comp.getPostThumbnail(post),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
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
      ),
    );
  }
}

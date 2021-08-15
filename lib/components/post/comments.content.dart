import 'package:fluddit/bloc/index.dart';
import 'package:fluddit/components/index.dart';
import 'package:fluddit/models/index.dart';
import 'package:flutter/material.dart';

class CommentContent extends StatelessWidget {
  CommentContent({Key? key, required this.post}) : super(key: key);

  final RedditPost post;

  final RedditController reddit = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length < 1) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 75,
                child: Center(
                  child: Text('No comments'),
                ),
              );
            } else {
              return CommentList(comments: snapshot.data);
            }
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.indigo[300],
              ),
            ),
          );
        },
        future: reddit.getPostComments(
          subreddit: post.subreddit,
          postId: post.id,
        ),
      ),
    );
  }
}

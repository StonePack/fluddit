import 'package:fluddit/bloc/reddit.bloc.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.post}) : super(key: key);

  final RedditPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      margin: EdgeInsets.all(5),
      height: 75,
      width: MediaQuery.of(context).size.width,
      child: ListTile(
          leading: Container(
            height: 75,
            width: 30,
            child: Center(child: Text('${post.score}')),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                post.title,
                maxLines: 2,
                style: TextStyle(
                  color: post.stickied ? Colors.green : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                post.author,
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          trailing: Container(
            color: Colors.blueGrey,
            height: 50,
            width: 50,
            child: post.thumbnail.contains('http')
                ? Image.network(
                    post.thumbnail,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Text('Tt'),
                  ),
          )),
    );
  }
}

class Comment {
  final String author;
  final String body;
  final String fullName;
  final String id;
  int level;
  final List<Comment> replies;
  int score;
  final String subreddit;
  int vote;

  Comment({
    required this.author,
    required this.body,
    required this.fullName,
    required this.id,
    this.level = 0,
    required this.replies,
    required this.score,
    required this.subreddit,
    required this.vote,
  });

  void updateVote(int vote) {
    switch (vote) {
      case 1:
        if (this.vote == 1) {
          this.vote = 0;
          --score;
        } else {
          if (this.vote == -1) {
            score = score + 2;
          } else {
            ++score;
          }
          this.vote = 1;
        }
        break;
      case -1:
        if (this.vote == -1) {
          this.vote = 0;
          ++score;
        } else {
          if (this.vote == 1) {
            score = score - 2;
          } else {
            --score;
          }
          this.vote = -1;
        }
        break;
      default:
        break;
    }
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'],
      body: _replaceHtml(json['body']),
      fullName: json['name'],
      id: json['id'],
      replies: _getReplies(json['replies']),
      score: json['score'],
      subreddit: json['subreddit'] ?? '',
      vote: _getVote(json['likes']),
    );
  }
}

String _replaceHtml(String text) {
  String formatedText = text.replaceAll('&gt;', '>');
  return formatedText;
}

// This is what causes the recursion to occur
List<Comment> _getReplies(replies) {
  if (replies == '') {
    // An empty string is set as the replies value if none are present ヘ(>_<ヘ)
    final List<Comment> comments = [];
    return comments;
  } else {
    final List<dynamic> replyArray = replies['data']['children'];
    replyArray.removeWhere((e) => e['kind'] == 'more');

    return replyArray.map((e) {
      return Comment.fromJson(e['data']);
    }).toList();
  }
}

int _getVote(bool? likes) {
  if (likes == null) {
    return 0;
  } else {
    return likes ? 1 : -1;
  }
}

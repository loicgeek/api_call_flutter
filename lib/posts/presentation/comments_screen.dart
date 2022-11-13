import 'package:api_calls/posts/data/models/comment_model.dart';
import 'package:api_calls/posts/data/models/post_model.dart';
import 'package:api_calls/posts/data/repositories/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;
  const CommentsScreen({
    super.key,
    required this.postId,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  List<CommentModel>? comments;
  @override
  void initState() {
    PostRepository(dio: Dio()).findComments(widget.postId).then((value) {
      setState(() {
        comments = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment for post ${widget.postId}")),
      body: comments == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                CommentModel commentItem = comments![index];
                return ListTile(
                  title: Text(commentItem.email),
                  subtitle: Text(commentItem.name),
                );
              },
            ),
    );
  }
}

import 'package:api_calls/posts/data/models/post_model.dart';
import 'package:api_calls/posts/data/repositories/post_repository.dart';
import 'package:api_calls/posts/presentation/comments_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<PostModel>? posts;
  @override
  void initState() {
    PostRepository(dio: Dio()).findPosts().then((value) {
      setState(() {
        posts = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: posts == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                PostModel postItem = posts![index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CommentsScreen(postId: postItem.id),
                      ),
                    );
                  },
                  title: Text(postItem.title),
                  subtitle:
                      Text("id:${postItem.id} - userId:${postItem.userId}"),
                );
              },
            ),
    );
  }
}

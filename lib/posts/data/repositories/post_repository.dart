import 'package:api_calls/posts/data/models/comment_model.dart';
import 'package:api_calls/posts/data/models/post_model.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final Dio dio;
  PostRepository({required this.dio});

  Future<List<PostModel>> findPosts() async {
    Response response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");

    List<PostModel> results = [];
    for (var i = 0; i < response.data.length; i++) {
      Map<String, dynamic> jsonItem = response.data[i];
      PostModel post = PostModel.fromJson(jsonItem);
      results.add(post);
    }
    return results;
  }

  Future<List<CommentModel>> findComments(int postId) async {
    Response response = await dio
        .get("https://jsonplaceholder.typicode.com/posts/${postId}/comments");

    List<CommentModel> results = [];
    for (var i = 0; i < response.data.length; i++) {
      Map<String, dynamic> jsonItem = response.data[i];
      CommentModel comment = CommentModel.fromJson(jsonItem);
      results.add(comment);
    }
    return results;
  }
}


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/post_model.dart';

class PostService {
  final Box<Post> postsBox = Hive.box<Post>('postsBox');

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final posts = data.map((json) => Post.fromJson(json)).toList();

        await postsBox.clear();

        for (var post in posts) {
          await postsBox.put(post.id, post);
        }

        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      if (postsBox.isNotEmpty) {
        return postsBox.values.toList();
      } else {
        throw Exception('No Internet and No Cached Data');
      }
    }
  }
}

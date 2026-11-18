
import 'package:hive/hive.dart';
import '../models/post_model.dart';

class FavoritesService {
  final Box<Post> favoritesBox = Hive.box<Post>('favoritesBox');

  // Add or remove a post from favorites
  Future<void> toggleFavorite(Post post) async {
    if (favoritesBox.containsKey(post.id)) {
      await favoritesBox.delete(post.id);
    } else {
      final favoritePost = Post(
        id: post.id,
        title: post.title,
        body: post.body,
        userId: post.userId,
      );

      await favoritesBox.put(post.id, favoritePost);
    }
  }

  // Check if a post is already a favorite
  bool isFavorite(int id) {
    return favoritesBox.containsKey(id);
  }

  // Get all favorite posts
  List<Post> getFavorites() {
    return favoritesBox.values.toList();
  }
}

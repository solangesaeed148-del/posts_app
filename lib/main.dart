
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/post_model.dart';
import 'screens/posts_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Post Adapter
  Hive.registerAdapter(PostAdapter());

  // Open Hive Boxes
  await Hive.openBox<Post>('postsBox');
  await Hive.openBox<Post>('favoritesBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Posts App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const PostsScreen(),
    );
  }
}

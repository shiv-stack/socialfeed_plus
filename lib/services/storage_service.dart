import 'package:hive_flutter/hive_flutter.dart';
import '../models/post.dart';

class StorageService {
  static const String postsBox = 'posts_box';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PostAdapter());
    await Hive.openBox<Post>(postsBox);
  }

  Box<Post> _postsBox() => Hive.box<Post>(postsBox);

  List<Post> getAllPosts() => _postsBox().values.toList().reversed.toList();

  Future<void> addPost(Post post) async => await _postsBox().put(post.id, post);

  Future<void> updatePost(Post post) async => await post.save();
}

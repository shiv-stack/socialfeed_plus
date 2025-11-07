import '../models/post.dart';
import '../services/storage_service.dart';

class PostRepository {
  final StorageService storage;

  PostRepository(this.storage);

  Future<List<Post>> loadPosts() async {
    return storage.getAllPosts();
  }

  Future<void> addPost(Post post) async {
    await storage.addPost(post);
  }

  Future<void> updatePost(Post post) async {
    await storage.updatePost(post);
  }
}

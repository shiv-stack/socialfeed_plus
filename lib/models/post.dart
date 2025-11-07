import 'package:hive/hive.dart';
part 'post.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String profileUrl; // local asset or network

  @HiveField(3)
  String caption;

  @HiveField(4)
  final String? imagePath; // local file path or network url

  @HiveField(5)
  final DateTime timestamp;

  @HiveField(6)
  int likeCount;

  @HiveField(7)
  bool isLiked;

  @HiveField(8)
  List<String> comments;

  Post({
    required this.id,
    required this.username,
    required this.profileUrl,
    required this.caption,
    this.imagePath,
    required this.timestamp,
    this.likeCount = 0,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}

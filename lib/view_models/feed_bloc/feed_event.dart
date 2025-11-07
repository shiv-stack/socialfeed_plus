import 'package:equatable/equatable.dart';
import '../../models/post.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFeed extends FeedEvent {}
class AddPostEvent extends FeedEvent {
  final Post post;
  AddPostEvent(this.post);
  @override List<Object?> get props => [post];
}
class ToggleLikeEvent extends FeedEvent {
  final String postId;
  ToggleLikeEvent(this.postId);
  @override List<Object?> get props => [postId];
}
class AddCommentEvent extends FeedEvent {
  final String postId;
  final String comment;
  AddCommentEvent(this.postId, this.comment);
  @override List<Object?> get props => [postId, comment];
}

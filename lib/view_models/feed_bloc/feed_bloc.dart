import 'package:flutter_bloc/flutter_bloc.dart';
import 'feed_event.dart';
import 'feed_state.dart';
import '../../repositories/post_repository.dart';
import '../../models/post.dart';
import 'package:uuid/uuid.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository repository;
  FeedBloc({required this.repository}) : super(FeedInitial()) {
    on<LoadFeed>(_onLoad);
    on<AddPostEvent>(_onAddPost);
    on<ToggleLikeEvent>(_onToggleLike);
    on<AddCommentEvent>(_onAddComment);
  }

  Future<void> _onLoad(LoadFeed e, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try {
      final posts = await repository.loadPosts();
      emit(FeedLoaded(posts));
    } catch (ex) {
      emit(FeedError('Failed to load feed'));
    }
  }

  Future<void> _onAddPost(AddPostEvent e, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      try {
        await repository.addPost(e.post);
        final posts = await repository.loadPosts();
        emit(FeedLoaded(posts));
      } catch (_) {
        emit(FeedError('Failed to add post'));
      }
    }
  }

  Future<void> _onToggleLike(ToggleLikeEvent e, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      final current = (state as FeedLoaded).posts;
      final idx = current.indexWhere((p) => p.id == e.postId);
      if (idx == -1) return;
      final post = current[idx];
      post.isLiked = !post.isLiked;
      post.likeCount += post.isLiked ? 1 : -1;
      await repository.updatePost(post);
      final posts = await repository.loadPosts();
      emit(FeedLoaded(posts));
    }
  }

  Future<void> _onAddComment(AddCommentEvent e, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      final current = (state as FeedLoaded).posts;
      final idx = current.indexWhere((p) => p.id == e.postId);
      if (idx == -1) return;
      final post = current[idx];
      post.comments.add(e.comment);
      await repository.updatePost(post);
      final posts = await repository.loadPosts();
      emit(FeedLoaded(posts));
    }
  }
}

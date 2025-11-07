import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialfeed_plus/themes/app_theme.dart';
import '../view_models/feed_bloc/feed_bloc.dart';
import '../view_models/feed_bloc/feed_state.dart';
import '../view_models/feed_bloc/feed_event.dart';
import '../widgets/post_card.dart';
import 'create_post_screen.dart';

class FeedScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SocialFeed+'),
        flexibleSpace: AppTheme.gradientAppBarBackground(),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreatePostScreen()))
          )
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) return Center(child: CircularProgressIndicator());
          if (state is FeedError) return Center(child: Text(state.message));
          if (state is FeedLoaded) {
            final posts = state.posts;
            if (posts.isEmpty) return Center(child: Text('No posts yet. Tap + to create.'));
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FeedBloc>().add(LoadFeed());
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, i) => PostCard(post: posts[i]),
              ),
            );
          }
          return SizedBox.shrink();
        }
      ),
    );
  }
}

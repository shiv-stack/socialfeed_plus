import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_models/feed_bloc/feed_bloc.dart';
import '../view_models/feed_bloc/feed_event.dart';
import 'animated_like.dart';

class PostCard extends StatelessWidget {
  final Post post;
  PostCard({required this.post});

  @override Widget build(BuildContext context) {
    final timeStr = DateFormat.yMMMd().add_jm().format(post.timestamp);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(backgroundImage: AssetImage(post.profileUrl), radius: 20),
            SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(post.username, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(timeStr, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
            Spacer(),
          ]),
          SizedBox(height: 12),
          Text(post.caption),
          if (post.imagePath != null) ...[
            SizedBox(height: 8),
            Image.file(File(post.imagePath!), fit: BoxFit.cover) // local images only; add network case if needed
          ],
          SizedBox(height: 8),
          Row(children: [
            GestureDetector(
              onTap: () => context.read<FeedBloc>().add(ToggleLikeEvent(post.id)),
              child: Row(children: [
                AnimatedLike(isLiked: post.isLiked),
                SizedBox(width: 6),
                Text('${post.likeCount}')
              ]),
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.comment),
              onPressed: () => _showAddComment(context),
            ),
          ]),
          if (post.comments.isNotEmpty) ...[
            Divider(),
            ...post.comments.map((c) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('• $c', style: TextStyle(fontSize: 13)),
            ))
          ]
        ]),
      ),
    );
  }

  void _showAddComment(BuildContext ctx) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: ctx,
      builder: (_) => Padding(
        padding: EdgeInsets.all(12),
        child: Row(children: [
          Expanded(child: TextField(controller: ctrl, decoration: InputDecoration(hintText: 'Add a comment'))),
          IconButton(onPressed: () {
            final txt = ctrl.text.trim();
            if (txt.isNotEmpty) {
              ctx.read<FeedBloc>().add(AddCommentEvent(post.id, txt));
              Navigator.of(ctx).pop();
            }
          }, icon: Icon(Icons.send))
        ]),
      )
    );
  }
}

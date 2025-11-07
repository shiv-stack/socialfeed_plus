import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialfeed_plus/themes/app_theme.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/ai_service.dart';
import '../models/post.dart';
import '../view_models/feed_bloc/feed_bloc.dart';
import '../view_models/feed_bloc/feed_event.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _captionCtrl = TextEditingController();
  File? _image;
  bool _loadingCaption = false;
  final _ai = AIService();

  Future<void> _pickImage() async {
    final p = ImagePicker();
    final res = await p.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (res != null) setState(() => _image = File(res.path));
  }

  Future<void> _generateCaption() async {
    setState(() => _loadingCaption = true);
    final caption = await _ai.generateCaption();
    _captionCtrl.text = caption;
    setState(() => _loadingCaption = false);
  }

  void _post() {
    final text = _captionCtrl.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Caption cannot be empty')));
      return;
    }

    final id = Uuid().v4();
    final post = Post(
      id: id,
      username: 'You',
      profileUrl: 'assets/profile_placeholder.png',
      caption: text,
      imagePath: _image?.path,
      timestamp: DateTime.now(),
    );

    context.read<FeedBloc>().add(AddPostEvent(post));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        flexibleSpace: AppTheme.gradientAppBarBackground(),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _captionCtrl,
              minLines: 3,
              maxLines: 6,
              decoration: InputDecoration(hintText: 'Write a caption...'),
            ),
            SizedBox(height: 12),
            if (_image != null)
              Image.file(_image!, height: 220, fit: BoxFit.cover),
            Row(
              children: [
                IconButton(icon: Icon(Icons.image), onPressed: _pickImage),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: _loadingCaption ? null : _generateCaption,
                  icon: _loadingCaption
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(Icons.auto_awesome),
                  label: Text('Generate Caption'),
                ),
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: _post, child: Text('Post')),
          ],
        ),
      ),
    );
  }
}

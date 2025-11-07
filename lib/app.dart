import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialfeed_plus/view_models/feed_bloc/feed_event.dart';
import 'repositories/post_repository.dart';
import 'services/storage_service.dart';
import 'view_models/feed_bloc/feed_bloc.dart';
import 'screens/login_screen.dart';
import 'themes/app_theme.dart';

class MyApp extends StatelessWidget {
  final StorageService storage;
  MyApp({required this.storage});

  @override
  Widget build(BuildContext context) {
    final repo = PostRepository(storage);
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (_) => FeedBloc(repository: repo)..add(LoadFeed()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'SocialFeed+',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: LoginScreen(),
      ),
    );
  }
}

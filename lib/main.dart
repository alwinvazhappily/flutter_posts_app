import 'package:flutter/material.dart';
import 'package:flutter_posts_app/core/theme/theme.dart';
import 'package:flutter_posts_app/core/utils/responsive_helper.dart';
import 'package:flutter_posts_app/presentation/screens/posts/post_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          ResponsiveHelper().init(
            constraints,
            orientation,
          ); // Initialize the Responsive Helper.

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Posts App',
            theme: AppTheme.lightThemeMode,
            home: const PostListScreen(),
          );
        });
      },
    );
  }
}

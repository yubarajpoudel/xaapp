import 'package:flutter/material.dart';
import 'package:myapp/modal/comment.dart';
import 'package:myapp/ui/post_detail.dart';
import 'package:myapp/ui/post_list.dart';
import 'package:provider/provider.dart';

import 'modal/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XA App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(
            builder: (context) {
              return MultiProvider(child: PostList(), providers: [
                ChangeNotifierProvider(
                  create: (context) => Post(),
                )
              ]);
            },
          );
        } else if (settings.name == "/${PostDetail.TAG}") {
          return MaterialPageRoute(
            builder: (context) {
              return MultiProvider(child: PostDetail(post: settings.arguments as Post,), providers: [
                ChangeNotifierProvider(
                  create: (context) => Comment(),
                )
              ]);
            },
          );
        }
      },
    );
  }
}

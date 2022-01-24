import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/enums.dart';
import 'package:provider/provider.dart';

class PostList extends StatelessWidget {
  Post? postNotifier;

  PostList({Key? key}) : super(key: key);

  _postItemView(Post post) {
    return ListTile(title: Text(post.title!), subtitle: Text(post.body!));
  }

  @override
  Widget build(BuildContext context) {
    postNotifier =  Provider.of<Post>(context, listen: false);
    postNotifier!.syncFromNetwork();
    return Scaffold(
      appBar: AppBar(title: const Text("PostList")),
      body: Consumer<Post>(
        builder: (context, post, child) {
          if (post.connectionStatus == ConnectionStatus.LOADING) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (post.connectionStatus == ConnectionStatus.ERROR) {
            return Center(
              child: Text(post.errorMessage ?? "Unknown error"),
            );
          } else {
            return ListView.builder(itemBuilder: (context, pos) {
              List<Post> postList = post.postList!;
              return _postItemView(postList[pos]);
            });
          }
        },
      ),
    );
  }
}

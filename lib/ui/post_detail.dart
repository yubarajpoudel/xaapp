import 'package:flutter/material.dart';
import 'package:myapp/modal/comment.dart';
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/enums.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatelessWidget {
  static const String TAG = "postDetail";
  Post? post;
  Comment? commentNotifier;

  PostDetail({Key? key, this.post}) : super(key: key);

  _commentItem(Comment comment) {
    return ListTile(
      title: Text(comment.email!),
      subtitle: Text(comment.body!),
    );
  }

  @override
  Widget build(BuildContext context) {
    commentNotifier = Provider.of<Comment>(context, listen: false);
    commentNotifier!.getAllComment("${post!.id}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                post!.title ?? "",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(post!.body ?? "", textAlign: TextAlign.left,),
              const SizedBox(
                height: 8.0,
              ),
              Consumer<Comment>(
                builder: (context, comment, child) {
                  if (comment.connectionStatus == ConnectionStatus.LOADING) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (comment.connectionStatus ==
                      ConnectionStatus.ERROR) {
                    return Center(
                      child: Text(comment.errorMessage ?? "Unknown error"),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: comment.commentList!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, pos) {
                            return _commentItem(comment.commentList![pos]);
                          }),
                    );
                  }
                },
              )
            ],
          ),
      ),
    );
  }
}

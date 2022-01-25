import 'package:flutter/material.dart';
import 'package:myapp/modal/comment.dart';
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/enums.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatelessWidget {
  static const String TAG = "postDetail";
  Post? post;
  Comment? commentNotifier;
  var commentController = TextEditingController();

  PostDetail({Key? key, this.post}) : super(key: key);

  _commentItem(Comment comment) {
    return Card(
      color: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
        title: Text(
          comment.email!,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          comment.body!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _addComment() {
    return Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: commentController,
              validator: (value) =>
                  value != null && value.isEmpty ? "* Required" : null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'comments here'),
            )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ))
          ],
        ));
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
              Text(
                post!.body ?? "",
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Consumer<Comment>(
                        builder: (context, comment, child) {
                          if (comment.connectionStatus ==
                              ConnectionStatus.LOADING) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (comment.connectionStatus ==
                              ConnectionStatus.ERROR) {
                            return Center(
                              child:
                                  Text(comment.errorMessage ?? "Unknown error"),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: comment.commentList!.length + 1,
                                itemBuilder: (context, pos) {
                                  if (pos == comment.commentList!.length) {
                                    return const SizedBox(
                                      height: 70,
                                    );
                                  } else {
                                    return _commentItem(
                                        comment.commentList![pos]);
                                  }
                                });
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _addComment(),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

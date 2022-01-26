import 'package:flutter/material.dart';
import 'package:myapp/modal/comment.dart';
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/api_consumer.dart';
import 'package:myapp/network/enums.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatelessWidget {
  static const String TAG = "postDetail";
  Post? post;
  Comment? commentNotifier;
  var commentController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  PostDetail({Key? key, this.post}) : super(key: key);

  _commentItem(Comment comment) {
    return Card(
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
        title: Text(
          comment.body!,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          comment.email!,
          style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 10),
        ),
      ),
    );
  }

  _addComment() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: Form(
            key: formKey,
            child: TextFormField(
              controller: commentController,
              validator: (value) =>
                  value != null && value.isEmpty ? "* Required" : null,
              decoration: const InputDecoration(hintText: 'comments here'),
            ),
          )),
          IconButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Map<String, Object> commentParams = {};
                  commentParams["postId"] = post!.id!;
                  commentParams["body"] = commentController.text;
                  commentParams["name"] = "Yubaraj Poudel";
                  commentParams["email"] = "yubarajpoudel708@gmail.com";

                  APIConsumer.addComment(commentParams).then((newComment) {
                    Utils.toast("New comment added successfully");
                    FocusManager.instance.primaryFocus?.unfocus();
                    commentController.text = "";
                  },
                      onError: (err) =>
                          Utils.toast(err.toString(), color: Colors.red));
                }
              },
              icon: const Icon(
                Icons.send,
              ))
        ],
      ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post!.title ?? "",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16,),
              Text(
                post!.body ?? "",
              ),
              const SizedBox(
                height: 8.0,
              ),

              const Text(
                "Comments",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0,),

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

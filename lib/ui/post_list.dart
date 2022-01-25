import 'package:flutter/material.dart';
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/api_consumer.dart';
import 'package:myapp/network/enums.dart';
import 'package:myapp/ui/post_detail.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class PostList extends StatelessWidget {
  Post? postNotifier;
  var formKey = GlobalKey<FormState>();
  var postTitleAddController = TextEditingController();
  var postBodyController = TextEditingController();

  static const String TAG = "PostList";

  PostList({Key? key}) : super(key: key);

  _postItemView(BuildContext context, Post post) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
          onTap: () => Navigator.pushNamed(context, "/${PostDetail.TAG}",
              arguments: post),
          selectedTileColor: Colors.lightBlue,
          title: Text(
            post.title!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            post.body!,
            maxLines: 2,
          )),
    );
  }

  _addPostPage(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
              child: GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                        key: formKey,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: postTitleAddController,
                                validator: (value) =>
                                    value != null && value.isEmpty
                                        ? "* Required"
                                        : null,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Title',
                                    hintText: 'Add post title'),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                controller: postBodyController,
                                maxLines: 4,
                                validator: (value) =>
                                    value != null && value.isEmpty
                                        ? "* Required"
                                        : null,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Message',
                                    hintText: 'Add message'),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      Map<String, Object> postParams = {};
                                      postParams["title"] =
                                          postTitleAddController.text;
                                      postParams["body"] =
                                          postBodyController.text;
                                      postParams["userId"] = 1;
                                      APIConsumer.addPost(postParams).then(
                                          (newPost) {
                                        Utils.toast(
                                            "new Post added successfully");
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        postTitleAddController.text = "";
                                        postBodyController.text = "";
                                      },
                                          onError: (err) => Utils.toast(
                                              err.toString(),
                                              color: Colors.red));
                                    }
                                  },
                                  child: const Text('Add Post'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))));
        });
  }

  @override
  Widget build(BuildContext context) {
    postNotifier = Provider.of<Post>(context, listen: false);
    postNotifier!.getAllPost();
    return Scaffold(
      appBar: AppBar(
        title: const Text("PostList"),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Consumer<Post>(
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
                  return _postItemView(context, postList[pos]);
                });
              }
            },
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addPostPage(context);
        },
        label: const Text("New Post"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

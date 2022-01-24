import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/api.dart';

class APIConsumer {
  static const String TAG = "APIConsumer";

  static Future<List<Post>?> getPostList() {
    print("$TAG , endpoint = ${EndPoint.POST.url}");
    return http.get(EndPoint.POST.url).then(
        (response) {
      if (response.statusCode == 200) {
        List<Post>? postList =(jsonDecode(response.body) as List<dynamic>?)
            ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
        return postList;

      } else {
        return Future.error(ErrorDescription("Unknown error"));
      }
    }, onError: (error) => Future.error(ErrorDescription(error.toString())));
  }
}

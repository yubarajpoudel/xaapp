import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/modal/comment.dart';
import 'package:myapp/modal/post.dart';
import 'package:myapp/network/api.dart';

import '../utils.dart';

class APIConsumer {
  static const String TAG = "APIConsumer";

  static Future<List<Post>?> getPostList() {
    Log.d("$TAG , endpoint = ${EndPoint.POST.url}");
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

  static Future<Post> addPost(Map<String, Object> params) {
    return http.post(EndPoint.POST.url, body: jsonEncode(params), headers: {'Content-type': 'application/json; charset=UTF-8'}).then(
            (response) {
              Log.d("$TAG, addPost:: ${response.statusCode}");
          if (response.statusCode == 201) {
             return Post.fromJson(jsonDecode(response.body));
          } else {
            return Future.error(ErrorDescription("Unknown error"));
          }
        }, onError: (error) => Future.error(ErrorDescription(error.toString())));
  }

  static Future<List<Comment>?> getCommentList(String postId) {
    Uri url = EndPoint.COMMENT.url.replace(queryParameters: {'postId': postId});
    Log.d("$TAG , endpoint = $url");
    return http.get(url).then(
            (response) {
          if (response.statusCode == 200) {
            List<Comment>? commentList =(jsonDecode(response.body) as List<dynamic>?)
                ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
                .toList();
            return commentList;

          } else {
            return Future.error(ErrorDescription("Unknown error"));
          }
        }, onError: (error) => Future.error(ErrorDescription(error.toString())));
  }

  static Future<Comment> addComment(String postId, Map<String, Object> params) {
    Uri url = EndPoint.COMMENT.url.replace(queryParameters: {'postId': postId});
    return http.post(url, body: jsonEncode(params), headers: {'Content-type': 'application/json; charset=UTF-8'}).then(
            (response) {
          Log.d("$TAG, addComment:: ${response.statusCode}");
          if (response.statusCode == 201) {
            return Comment.fromJson(jsonDecode(response.body));
          } else {
            return Future.error(ErrorDescription("Unknown error"));
          }
        }, onError: (error) => Future.error(ErrorDescription(error.toString())));
  }


}

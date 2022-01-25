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
    return Utils.isInternetConnected().then((connected) {
      if(connected ?? false) {
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
      } else {
        return Future.error(ErrorDescription("No Active Internet Connection Found"));
      }
    });

  }

  static Future<Post> addPost(Map<String, Object> params) {
    return Utils.isInternetConnected().then((connected) {
      if(connected ?? false) {
        return http.post(EndPoint.POST.url, body: jsonEncode(params), headers: {'Content-type': 'application/json; charset=UTF-8'}).then(
                (response) {
              Log.d("$TAG, addPost:: ${response.statusCode}");
              if (response.statusCode == 201) {
                return Post.fromJson(jsonDecode(response.body));
              } else {
                return Future.error(ErrorDescription("Unknown error"));
              }
            }, onError: (error) => Future.error(ErrorDescription(error.toString())));
      } else {
        return Future.error(ErrorDescription("No Active Internet Connection Found"));
      }
    });

  }

  static Future<List<Comment>?> getCommentList(String postId) {
    return Utils.isInternetConnected().then((connected) {
      if(connected ?? false) {
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
      } else {
        return Future.error(ErrorDescription("No Active Internet Connection Found"));
      }
    });

  }

  static Future<Comment> addComment(Map<String, Object> params) {
    return Utils.isInternetConnected().then((connected) {
      if(connected ?? false) {
        return http.post(EndPoint.COMMENT.url, body: jsonEncode(params), headers: {'Content-type': 'application/json; charset=UTF-8'}).then(
                (response) {
              Log.d("$TAG, addComment:: ${response.statusCode}");
              if (response.statusCode == 201) {
                return Comment.fromJson(jsonDecode(response.body));
              } else {
                return Future.error(ErrorDescription("Unknown error"));
              }
            }, onError: (error) => Future.error(ErrorDescription(error.toString())));
      } else {
        return Future.error(ErrorDescription("No Active Internet Connection Found"));
      }
    });

  }


}

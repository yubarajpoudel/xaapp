
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/network/api_consumer.dart';
import 'package:myapp/network/enums.dart';
part 'post.g.dart';

@JsonSerializable()
class Post extends ChangeNotifier {
  int? userId;
  int? id;
  String? title;
  String? body;

  @JsonKey(ignore: true)
  List<Post>? postList;
  @JsonKey(ignore: true)
  String? errorMessage;
  @JsonKey(ignore: true)
  ConnectionStatus? connectionStatus;
  Post();


  Post.init(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
  updateState(ConnectionStatus connectionState) {
    connectionStatus = connectionState;
    notifyListeners();
  }

  syncFromNetwork() {
    updateState(ConnectionStatus.LOADING);
    APIConsumer.getPostList().then((List<Post>? mPostList) {
      connectionStatus = ConnectionStatus.DONE;
      if(mPostList != null) {
        postList = mPostList;
      } else {
        errorMessage = "Error in getting postList";
      }
      notifyListeners();
    }, onError: (error) {
      errorMessage = error.toString();
      updateState(ConnectionStatus.ERROR);
      notifyListeners();
    });
  }
}
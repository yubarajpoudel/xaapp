import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myapp/network/api_consumer.dart';
import 'package:myapp/network/enums.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment extends ChangeNotifier {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  @JsonKey(ignore: true)
  List<Comment>? commentList;
  @JsonKey(ignore: true)
  String? errorMessage;
  @JsonKey(ignore: true)
  ConnectionStatus? connectionStatus;

  Comment();

  Comment.init(this.postId, this.id, this.name, this.email, this.body);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  updateState(ConnectionStatus connectionState) {
    connectionStatus = connectionState;
    notifyListeners();
  }


  getAllComment(String postId) {
    updateState(ConnectionStatus.LOADING);
    APIConsumer.getCommentList(postId).then((List<Comment>? mCommentList) {
      connectionStatus = ConnectionStatus.DONE;
      if(mCommentList != null) {
        commentList = mCommentList;
      } else {
        errorMessage = "Error in getting commentList";
      }
      notifyListeners();
    }, onError: (error) {
      errorMessage = error.toString();
      updateState(ConnectionStatus.ERROR);
      notifyListeners();
    });
  }
}
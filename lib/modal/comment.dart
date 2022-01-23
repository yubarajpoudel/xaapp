import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment extends ChangeNotifier {
  String? userComment;
  String? createdAt;
  String? userName;
  Comment();
  Comment.init({this.userComment, this.createdAt, this.userName});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment extends ChangeNotifier {
  String? postId;
  int? id;
  String? name;
  String? email;
  String? body;
  Comment();

  Comment.init(this.postId, this.id, this.name, this.email, this.body);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
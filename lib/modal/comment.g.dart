// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..userComment = json['userComment'] as String?
    ..createdAt = json['createdAt'] as String?
    ..userName = json['userName'] as String?;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'userComment': instance.userComment,
      'createdAt': instance.createdAt,
      'userName': instance.userName,
    };

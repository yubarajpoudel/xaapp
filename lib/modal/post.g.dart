// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..id = json['id'] as String?
    ..title = json['title'] as String?
    ..desc = json['desc'] as String?
    ..image = json['image'] as String?
    ..createdAt = json['createdAt'] as String?
    ..comments = (json['comments'] as List<dynamic>?)
        ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'comments': instance.comments,
    };

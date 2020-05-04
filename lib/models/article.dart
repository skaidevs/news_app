import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:newsapp/models/serializers.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;
  int get id;
  @nullable
  bool get deleted;
  @nullable
  String get type;
  @nullable
  String get by;
  @nullable
  int get time;
  @nullable
  String get text;
  @nullable
  bool get dead;
  @nullable
  int get parent;
  @nullable
  int get poll;
  @nullable
  BuiltList<int> get kids;
  @nullable
  String get url;
  @nullable
  int get score;
  @nullable
  String get title;
  @nullable
  BuiltList<int> get parts;
  @nullable
  int get descendants;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseTopStories(String jsonStr) {
  return [];
  /*final parsed = jsonDecode(jsonStr);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;*/
}

Article parseArticle(String jsonStr) {
  final parsed = jsonDecode(jsonStr);
  Article article =
      standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}

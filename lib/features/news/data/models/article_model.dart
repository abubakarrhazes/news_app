import 'dart:convert';

import 'package:news_app/features/news/data/models/source_model.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:news_app/features/news/domain/entities/source_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required source,
    required author,
    required title,
    required description,
    required url,
    required urlToImage,
    required publishedAt,
    required content,
  }) : super(
            source: source,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source:
          json["source"] == null ? null : SourceModel.fromJson(json["source"]),
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.tryParse(json["publishedAt"] ?? ""),
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
        "source": (source as SourceModel).toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}

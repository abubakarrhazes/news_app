// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';

NewsResponseModel newsResponseModelFromJson(String str) =>
    NewsResponseModel.fromJson(json.decode(str));

String newsResponseModelToJson(NewsResponseModel data) =>
    json.encode(data.toJson());

class NewsResponseModel {
  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String? status;
  final int? totalResults;
  final List<ArticleEntity> articles;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: json["articles"] == null
          ? []
          : List<ArticleModel>.from(
              json["articles"]!.map((x) => ArticleModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(
            (articles as List<ArticleModel>).map((x) => x.toJson())),
      };
}

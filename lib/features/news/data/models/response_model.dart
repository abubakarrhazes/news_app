// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';

class ResponseModel {
  ResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String? status;
  final int? totalResults;
  final List<ArticleEntity> articles;

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
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

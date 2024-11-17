// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:news_app/core/constants/app_strings.dart';

import 'package:http/http.dart' as http;
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/network/api_provider.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';

abstract class NewsRemoteSource {
  Future<ArticlesModel> getAllNews();
}

class NewsRemoteSourceImpl implements NewsRemoteSource {
  final APIProvider apiProvider;

  NewsRemoteSourceImpl({
    required this.apiProvider,
  });

  @override
  Future<ArticlesModel> getAllNews() async {
    final response = await apiProvider.get(endPoint: newsEndPoint);
    return ArticlesModel.fromJson(response.data);
  }
}

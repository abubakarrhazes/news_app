// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:news_app/core/constants/app_strings.dart';

import 'package:http/http.dart' as http;
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/features/news/data/models/response_model.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';

abstract class NewsRemoteSource {
  Future<NewsResponseModel> getNews(FilterNewsParams params);
}

class NewsRemoteSourceImpl implements NewsRemoteSource {
  final http.Client client;

  NewsRemoteSourceImpl({
    required this.client,
  });

  @override
  Future<NewsResponseModel> getNews(params) => _getNewsFromUrl(
      '${AppStrings.base_url}/top-headlines?country=${params.country}&apiKey=${params.apiKey}&category=${params.category}&page=${params.page}&pageSize=${params.pageSize}');

  Future<NewsResponseModel> _getNewsFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return newsResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}

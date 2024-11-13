// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/features/news/data/models/response_model.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';

abstract class NewsRemoteSource {
  Future<ResponseModel> getNews(FilterNewsParams params);
}

class NewsRemoteSourceImpl implements NewsRemoteSource {
  final http.Client client;

  
  NewsRemoteSourceImpl({
    required this.client,
  });

  
  @override
  Future<ResponseModel> getNews(FilterNewsParams params) {
    // TODO: implement getNews
    throw UnimplementedError();
  }
}

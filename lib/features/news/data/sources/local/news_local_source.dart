import 'dart:convert';

import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/features/news/data/models/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsLocalSource {
  Future<NewsResponseModel> getLastNews();
  Future<void> saveNews(NewsResponseModel newsToCache);
}

const cachedNews = 'CACHED_NEWS';

class NewsLocalSourceImpl implements NewsLocalSource {
  final SharedPreferences preferences;

  NewsLocalSourceImpl({required this.preferences});

  @override
  Future<NewsResponseModel> getLastNews() {
    final jsonString = preferences.getString(cachedNews);
    if (jsonString != null) {
      return Future.value(newsResponseModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveNews(NewsResponseModel newsToCache) {
    return preferences.setString(
      cachedNews,
      json.encode(newsResponseModelToJson(newsToCache)),
    );
  }
}

import 'dart:convert';

import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsLocalSource {
  Future<ArticlesModel> getLastNews();
  //Future<void> saveNews(ArticlesModel newsToCache);
}

const cachedNews = 'CACHED_NEWS';

class NewsLocalSourceImpl implements NewsLocalSource {
  final SharedPreferences preferences;

  NewsLocalSourceImpl({required this.preferences});

  @override
  Future<ArticlesModel> getLastNews() {
    final jsonString = preferences.getString(cachedNews);
    if (jsonString != null) {
      return Future.value(ArticlesModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  // @override
  // Future<void> saveNews(ArticlesModel newsToCache) {
  //   return preferences.setString(
  //     cachedNews,
  //     json.encode(newsResponseModelToJson(newsToCache)),
  //   );
  // }
}

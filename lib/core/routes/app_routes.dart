import 'package:flutter/material.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/features/home/presentation/pages/layout.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:news_app/features/news/presentation/screens/news_details_view.dart';

class AppRoutes {
  //main menu
  static const String home = '/';

  static const String newsDetails = '/news-details';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => const Layout(),);

      case newsDetails:
        ArticleEntity articles = routeSettings.arguments as ArticleEntity;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsView(
                  articles: articles,
                ));

      default:
        throw const RouteException('Route not found!');
    }
  }
}

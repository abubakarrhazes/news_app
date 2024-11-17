import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';

abstract class NewsRepo {
  Future<Either<Failure, ArticlesEntity>> getAllNews();
}

import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/exceptions.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/network/network_info.dart';

import 'package:news_app/features/news/data/sources/local/news_local_source.dart';
import 'package:news_app/features/news/data/sources/remote/news_remote_source.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:news_app/features/news/domain/repo/news_repo.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';

class NewsRepoImpl implements NewsRepo {
  final NewsLocalSource newsLocalSource;

  final NewsRemoteSource newsRemoteSource;
  final NetworkInfo networkInfo;

  NewsRepoImpl(
      {required this.newsLocalSource,
      required this.newsRemoteSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, ArticlesEntity>> getAllNews() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await newsRemoteSource.getAllNews();
        print(data);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNews = await newsLocalSource.getLastNews();
        return Right(localNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

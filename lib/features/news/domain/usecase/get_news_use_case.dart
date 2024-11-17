import 'package:dartz/dartz.dart';
import 'package:news_app/core/constants/app_strings.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/usecases/usecase.dart';

import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:news_app/features/news/domain/repo/news_repo.dart';

class GetAllNewsUseCase implements UseCase<ArticlesEntity, NoParams> {
  final NewsRepo newsRepo;

  GetAllNewsUseCase({required this.newsRepo});

  @override
  Future<Either<Failure, ArticlesEntity>> call(NoParams params) {
    // TODO: implement call
    return newsRepo.getAllNews();
  }
}

class FilterNewsParams {
  final String? category;
  final String? apiKey;
  final String? country;
  final int? page;
  final int? pageSize;

  const FilterNewsParams({
    this.category = 'general',
    this.apiKey = API_KEY,
    this.country = 'us',
    this.page = 1,
    this.pageSize = 10,
  });

  FilterNewsParams copyWith({
    int? skip,
    String? category,
    String? apiKey,
    String? country,
    int? page,
    int? pageSize,
  }) =>
      FilterNewsParams(
        category: category ?? this.category,
        apiKey: apiKey ?? this.apiKey,
        country: country ?? this.country,
        page: skip ?? this.page,
        pageSize: pageSize ?? this.pageSize,
      );
}

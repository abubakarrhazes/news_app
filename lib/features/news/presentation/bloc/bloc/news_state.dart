part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  final List<ArticleEntity> articles;
  
  const NewsState({required this.articles,});
}

class NewsInitial extends NewsState {
  const NewsInitial({
    required super.articles,
  });
  @override
  List<Object> get props => [];
}

class NewsEmpty extends NewsState {
  const NewsEmpty({
    required super.articles,
  });
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  const NewsLoading({
    required super.articles,
    
  });
  @override
  List<Object> get props => [];
}

class NewsLoaded extends NewsState {
  const NewsLoaded({
    required super.articles,
    
  });
  @override
  List<Object> get props => [articles];
}

class NewsError extends NewsState {
  final Failure failure;
  const NewsError({
    required super.articles,
    required this.failure,
  });
  @override
  List<Object> get props => [];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetAllNewsUseCase getAllNewsUseCase;

  NewsBloc(this.getAllNewsUseCase)
      : super(const NewsInitial(
          articles:  [],
        )) {
    on<GetNews>(_onLoadNews);
  }

  void _onLoadNews(GetNews event, Emitter<NewsState> emit) async {
    try {
      emit(const NewsLoading(
        articles: [],
      ));
      final result = await getAllNewsUseCase(NoParams());
      result.fold(
        (failure) => emit(NewsError(
          articles: state.articles,
          failure: failure,
        )),
        (newsResponse) => emit(NewsLoaded(
          articles: newsResponse.articles,
        )),
      );
    } catch (e) {
      emit(
        NewsError(
          articles: state.articles,
          failure: ExceptionFailure(),
        ),
      );
    }
  }
}

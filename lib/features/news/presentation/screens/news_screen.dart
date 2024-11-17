import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/images.dart';
import 'package:news_app/core/error/failures.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';
import 'package:news_app/features/news/presentation/bloc/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets/alert_card.dart';
import 'package:news_app/features/news/presentation/widgets/news_card.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController scrollController = ScrollController();

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;
    if (currentScroll > (maxScroll * scrollPercentage)) {
      if (context.read<NewsBloc>().state is NewsLoaded) {
        context.read<NewsBloc>().add(const GetMoreNews());
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                //Result Empty and No Error
                if (state is NewsLoaded && state.articles.isEmpty) {
                  return const AlertCard(
                    image: kEmpty,
                    message: "News not found!",
                  );
                }
                //Error and no preloaded data
                if (state is NewsError && state.articles.isEmpty) {
                  if (state.failure is NetworkFailure) {
                    return AlertCard(
                      image: kNoConnection,
                      message: "Network failure\nTry again!",
                      onClick: () {
                        context
                            .read<NewsBloc>()
                            .add(const GetNews());
                      },
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.failure is ServerFailure)
                        Image.asset('assets/images/internal-server-error.png'),
                      if (state.failure is CacheFailure)
                        Image.asset('assets/images/no-connection.png'),
                      const Text("News not found!"),
                      IconButton(
                          onPressed: () {
                            context
                                .read<NewsBloc>()
                                .add(const GetNews());
                          },
                          icon: const Icon(Icons.refresh)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      )
                    ],
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<NewsBloc>()
                        .add(const GetNews());
                  },
                  child: GridView.builder(
                    itemCount: state.articles.length +
                        ((state is NewsLoading) ? 10 : 0),
                    controller: scrollController,
                    padding: EdgeInsets.only(
                        top: 18,
                        left: 20,
                        right: 20,
                        bottom: (80 + MediaQuery.of(context).padding.bottom)),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                    ),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (state.articles.length > index) {
                        return NewsCard(
                          articles: state.articles[index],
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade100,
                          highlightColor: Colors.white,
                          child: const NewsCard(),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/features/news/domain/entities/article_entities.dart';
import 'package:shimmer/shimmer.dart';

class NewsCard extends StatelessWidget {
  final ArticleEntity? articles;
  final Function? onFavoriteToggle;
  final Function? onClick;
  const NewsCard({
    Key? key,
    this.articles,
    this.onFavoriteToggle,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return articles == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.white,
            child: buildBody(context),
          )
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (articles != null) {
          Navigator.of(context)
              .pushNamed(AppRoutes.newsDetails, arguments: articles);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
              border: Border.all(
                color: Theme.of(context).shadowColor.withOpacity(0.15),
              ),
            ),
            // Card(
            //   color: Colors.white,
            //   elevation: 0,
            //   margin: const EdgeInsets.all(4),
            //   clipBehavior: Clip.antiAlias,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            child: articles == null
                ? Material(
                    child: GridTile(
                      footer: Container(),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  )
                : Hero(
                    tag: articles!.title!,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CachedNetworkImage(
                        imageUrl: articles!.urlToImage!,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade100,
                          highlightColor: Colors.white,
                          child: Container(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ),
          )),
          Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
              child: SizedBox(
                height: 18,
                child: articles == null
                    ? Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                    : Text(
                        articles!.title!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
              )),
          
        ],
      ),
    );
  }
}

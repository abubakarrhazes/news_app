
import 'package:flutter/material.dart';

import 'package:news_app/features/news/domain/entities/article_entities.dart';

class ProductDetailsView extends StatefulWidget {
  final ArticleEntity articles;
  const ProductDetailsView({Key? key, required this.articles})
      : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 14, top: 20, bottom: 4),
            child: Text(
              widget.articles.title!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 10,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom),
            child: Text(
              widget.articles.content!,
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

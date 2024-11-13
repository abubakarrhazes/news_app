import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/color_manager.dart';
import 'package:news_app/features/home/presentation/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/features/news/presentation/screens/bookmark_screen.dart';
import 'package:news_app/features/news/presentation/screens/news_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorManager.white,
          selectedItemColor: ColorManager.orangeLight,
          unselectedItemColor: ColorManager.grey,
          onTap: (index) {
            switch (index) {
              case 0:
                BlocProvider.of<BottomNavigationBarBloc>(context)
                    .add(LoadHome());
                break;
              case 1:
                BlocProvider.of<BottomNavigationBarBloc>(context)
                    .add(LoadBookmark());

                break;
              default:
                BlocProvider.of<BottomNavigationBarBloc>(context)
                    .add(LoadHome());
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline),
                label: 'Bookmark',
                activeIcon: Icon(Icons.bookmark)),
          ],
        ),
        body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
          builder: (context, state) {
            if (state is HomeState) {
              return const NewsScreen();
            } else if (state is BookmarkState) {
              return const BookmarkScreen();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

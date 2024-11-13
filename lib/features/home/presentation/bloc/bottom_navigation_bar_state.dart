part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarState extends Equatable {
  const BottomNavigationBarState();
  final int index = 0;
  @override
  List<Object> get props => [];
}

class HomeState extends BottomNavigationBarState {
  @override
  final int index = 0;
  final String title = 'Home';

  @override
  List<Object> get props => [index, title];
}

class BookmarkState extends BottomNavigationBarState {
  @override
  final int index = 1;
  final String title = 'Bookmark';

  @override
  List<Object> get props => [index, title];
}

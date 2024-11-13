part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarEvent extends Equatable {
  const BottomNavigationBarEvent();

  @override
  List<Object> get props => [];
}

class LoadHome extends BottomNavigationBarEvent {
  @override
  List<Object> get props => [];
}

class LoadBookmark extends BottomNavigationBarEvent {
  @override
  List<Object> get props => [];
}

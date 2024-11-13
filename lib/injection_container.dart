import 'package:get_it/get_it.dart';
import 'package:news_app/features/home/presentation/bloc/bottom_navigation_bar_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  injector.registerFactory(() => BottomNavigationBarBloc());
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/features/home/presentation/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/features/home/presentation/pages/layout.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';
import 'package:news_app/features/news/presentation/bloc/bloc/news_bloc.dart';
import 'package:news_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<BottomNavigationBarBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<NewsBloc>()..add(const GetNews()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter News App',
        theme: ThemeData(
          // tested with just a hot reload.

          useMaterial3: true,
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

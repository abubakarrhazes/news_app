import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/presentation/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/features/home/presentation/pages/layout.dart';
import 'package:news_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
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
          create: (context) => injector<BottomNavigationBarBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter News App',
        theme: ThemeData(
          // tested with just a hot reload.

          useMaterial3: true,
        ),
        home: const Layout(),
      ),
    );
  }
}

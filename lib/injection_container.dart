import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/core/network/api_provider.dart';
import 'package:news_app/core/network/api_provider_impl.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/home/presentation/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/features/news/data/repo/news_repo_impl.dart';
import 'package:news_app/features/news/data/sources/local/news_local_source.dart';
import 'package:news_app/features/news/data/sources/remote/news_remote_source.dart';
import 'package:news_app/features/news/domain/repo/news_repo.dart';
import 'package:news_app/features/news/domain/usecase/get_news_use_case.dart';
import 'package:news_app/features/news/presentation/bloc/bloc/news_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs Registration
  sl.registerFactory(() => BottomNavigationBarBloc());

  // Bloc
  sl.registerFactory(
    () => NewsBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetAllNewsUseCase(
      newsRepo: sl(),
    ),
  );
  // Repository
  sl.registerLazySingleton<NewsRepo>(
    () => NewsRepoImpl(
      newsLocalSource: sl(),
      newsRemoteSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<NewsRemoteSource>(
    () => NewsRemoteSourceImpl(
      apiProvider: sl(),
    ),
  );
  sl.registerLazySingleton<NewsLocalSource>(() => NewsLocalSourceImpl(
        preferences: sl(),
      ));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<APIProvider>(() => APIProviderImpl());


  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:pin_app_challenge/data/datasources/post_http_datasource.dart';
import 'package:pin_app_challenge/data/datasources/post_swift_datasource.dart';
import 'package:pin_app_challenge/data/repositories/post_repository_impl.dart';
import 'package:pin_app_challenge/domain/repositories/post_repository.dart';
import 'package:pin_app_challenge/presentation/home/bloc/home_bloc.dart';
import 'package:pin_app_challenge/presentation/comments/bloc/comments_bloc.dart';
import 'package:pin_app_challenge_post_sdk/pin_app_challenge_post_sdk.dart';

GetIt sl = GetIt.instance;

void setupDI() {
  sl.registerSingleton<PinAppChallengePostSdk>(PinAppChallengePostSdk());
  sl.registerSingleton<Client>(Client());
  sl.registerSingleton<PostSwiftDatasource>(PostSwiftDatasource(sl()));
  sl.registerSingleton<PostHttpDatasource>(PostHttpDatasource(sl()));
  sl.registerSingleton<PostRepository>(PostRepositoryImpl(sl(), sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
  sl.registerFactory<CommentsBloc>(() => CommentsBloc(sl()));
}

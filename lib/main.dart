import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttartur/app/app.dart';
import 'package:fluttartur/firebase_options.dart';
import 'package:data_api_repository/data_api_repository.dart';
import 'package:cache/cache.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final cacheClient = CacheClient();
  final dataRepository = DataApiRepository(cache: cacheClient);
  final authenticationRepository = AuthenticationRepository(cache: cacheClient);
  await authenticationRepository.user.first;

  runApp(App(
    authenticationRepository: authenticationRepository,
    dataRepository: dataRepository,
  ));
}

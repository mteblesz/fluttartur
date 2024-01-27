import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttartur/app/app.dart';
import 'package:fluttartur/firebase_options.dart';
import 'package:cache/cache.dart';
import 'package:data_repository/data_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final cacheClient = CacheClient();
  final dataRepository = DataRepository(cacheClient: cacheClient);
  final authenticationRepository = AuthenticationRepository(cache: cacheClient);
  await authenticationRepository.user.first;

  runApp(App(
    authenticationRepository: authenticationRepository,
    dataRepository: dataRepository,
  ));
}

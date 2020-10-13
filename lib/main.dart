import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_observer/custom_bloc_observer.dart';
import 'pages/login/login_page.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepositoryProvider<AuthenticationRepository>(
      create: (BuildContext context) {
        final AuthenticationRepository _authenticationRepository = AuthenticationRepositoryImpl();
        return _authenticationRepository;
      },
      child: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          final AuthenticationRepository _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
          return AuthenticationBloc(authenticationRepository: _authenticationRepository);
        },
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amuse App',
      theme: ThemeData(
        primaryColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: LoginPage(),
    );
  }
}

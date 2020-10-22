import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/pages/common/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:amuse_app/pages/main/main_page.dart';
import 'package:amuse_app/pages/splash_screen.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_observer/custom_bloc_observer.dart';
import 'pages/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp();

  runApp(
    RepositoryProvider<AuthenticationRepository>(
      create: (BuildContext context) {
        final AuthenticationRepository _authenticationRepository = AuthenticationRepositoryImpl();
        return _authenticationRepository;
      },
      child: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          final AuthenticationRepository _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
          return AuthenticationBloc(authenticationRepository: _authenticationRepository)..add(AuthenticationTried());
        },
        child: AmuseApp(),
      ),
    ),
  );
}

class AmuseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amuse App',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext buildContext, AuthenticationState state) {
          if (state is AuthenticationTrySuccess) {
            return MainPage();
          }
          if (state is AuthenticationRequired) {
            return LoginPage();
          }
          if (state is AuthenticationInProgress) {
            return Scaffold(
              body: LoadingIndicator(),
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}

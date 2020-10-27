import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/pages/common/common_widgets/dismiss_keyboard_listener/dismiss_keyboard_listener.dart';
import 'package:amuse_app/pages/common/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:amuse_app/pages/main/main_page.dart';
import 'package:amuse_app/pages/splash_screen.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'blocs/bloc_observer/custom_bloc_observer.dart';
import 'pages/login/login_page.dart';

const FontWeight THIN = FontWeight.w100;
const FontWeight EXTRA_LIGHT = FontWeight.w200;
const FontWeight LIGHT = FontWeight.w300;
const FontWeight REGULAR = FontWeight.w400;
const FontWeight MEDIUM = FontWeight.w500;
const FontWeight SEMI_BOLD = FontWeight.w600;
const FontWeight BOLD = FontWeight.w700;
const FontWeight EXTRA_BOLD = FontWeight.w800;
const FontWeight BLACK = FontWeight.w900;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp();
  await DotEnv().load('assets/.env');

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
        primarySwatch: const MaterialColor(
          0xFFD9264A, //primaryColor
          <int, Color>{
            50: Color(0xFFCCCCCC), //secondaryHeaderColor
            100: Color(0xFF53C6FF), //primaryColorLight
            200: Color(0xFFF8F8F8), //textSelectionColor, backgroundColor
            300: Color(0xFFCCCCCC), //textSelectionHandleColor
            400: Color(0xFFD9264A), //primaryColor
            500: Color(0xFFFFD332), //accentColor
            600: Color(0xFFF8F8F8), //toggleableActiveColor
            700: Color(0xFF999999), //primaryColorDark
            800: Color(0xFFD1D5DB),
            900: Color(0xFF66E4F2),
          },
        ),
        fontFamily: 'NotoSansKR',
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      builder: (BuildContext buildContext, Widget child) => DismissKeyboardListener(
        child: child,
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

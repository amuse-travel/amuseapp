import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit<dynamic> cubit, Change<dynamic> change) {
    log(change.toString());
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit<dynamic> cubit, Object error, StackTrace stackTrace) {
    log('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}
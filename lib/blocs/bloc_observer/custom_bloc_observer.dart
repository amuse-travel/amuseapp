import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit<dynamic> cubit, Change<dynamic> change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit<dynamic> cubit, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}
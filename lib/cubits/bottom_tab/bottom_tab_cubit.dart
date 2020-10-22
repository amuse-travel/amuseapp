import 'package:amuse_app/enums/tab_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'bottom_tab_state.dart';

class BottomTabCubit extends Cubit<BottomTabState> {
  BottomTabCubit() : super(BottomTabInitial());

  void updateTab({TabEnum tabEnum}) => emit(BottomTabUpdated(tabEnum: tabEnum));
}

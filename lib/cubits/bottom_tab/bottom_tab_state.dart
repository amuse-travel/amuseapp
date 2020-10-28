part of 'bottom_tab_cubit.dart';

abstract class BottomTabState extends Equatable {
  const BottomTabState();

  @override
  List<Object> get props => <Object>[];
}

class BottomTabInitial extends BottomTabState {}

class BottomTabUpdated extends BottomTabState {
  const BottomTabUpdated({
    @required this.tabEnum,
  }) : assert(tabEnum != null);

  final TabEnum tabEnum;

  @override
  List<Object> get props => <Object>[tabEnum];
}

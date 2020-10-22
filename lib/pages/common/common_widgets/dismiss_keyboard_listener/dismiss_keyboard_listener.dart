import 'package:flutter/material.dart';

class DismissKeyboardListener extends StatelessWidget {
  const DismissKeyboardListener({
    @required this.child,
  }) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        final FocusScopeNode _currentFocus = FocusScope.of(context);
        if (!_currentFocus.hasPrimaryFocus && _currentFocus.focusedChild != null) {
          _currentFocus.focusedChild.unfocus();
        }
      },
      child: child,
    );
  }
}

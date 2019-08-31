import 'package:flutter/material.dart';

class DsWidgetSelector extends StatelessWidget {
  final bool condition;
  final Widget onTrue;
  final Widget onFalse;

  const DsWidgetSelector({Key key, this.condition, this.onTrue, this.onFalse})
      : assert(condition != null),
        assert(onTrue != null),
        assert(onFalse != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? onTrue : onFalse;
  }
}

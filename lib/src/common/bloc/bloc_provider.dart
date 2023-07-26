import 'package:flutter/cupertino.dart';
import 'package:iventas_challenge/src/common/bloc/bloc.dart';

final class BlocProvider<T extends Bloc> extends StatefulWidget {
  const BlocProvider({Key? key, required this.child, required this.bloc})
      : super(key: key);

  final T bloc;
  final Widget child;

  @override
  createState() => BlocProviderState();

  static T of<T extends Bloc>(BuildContext context) {
    BlocProvider? provider =
        context.findAncestorStateOfType<BlocProviderState>()?.widget;
    assert(provider != null);
    return provider!.bloc as T;
  }
}

class BlocProviderState<T> extends State<BlocProvider<Bloc>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

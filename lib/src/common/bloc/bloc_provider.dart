import 'package:flutter/cupertino.dart';
import 'package:iventas_challenge/src/common/bloc/bloc.dart';

final class BlocProvider<T extends Bloc> extends StatefulWidget {
  const BlocProvider({Key? key, required this.child, required this.blocs})
      : super(key: key);

  final List<Function> blocs;
  final Widget child;

  @override
  createState() => BlocProviderState(blocs.map<Bloc>((b) => b()).toList());

  static T of<T extends Bloc>(BuildContext? context) {
    BlocProviderState? provider =
        context?.findAncestorStateOfType<BlocProviderState>();

    T? bloc = provider?.blocs.firstWhere((b) => b is T) as T?;

    if (bloc != null) {
      return bloc;
    }

    return BlocProvider.of(provider?.context);
  }
}

class BlocProviderState<T> extends State<BlocProvider<Bloc>> {
  List<Bloc> blocs;

  BlocProviderState(this.blocs);

  @override
  void dispose() {
    for (var bloc in blocs) {
      bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

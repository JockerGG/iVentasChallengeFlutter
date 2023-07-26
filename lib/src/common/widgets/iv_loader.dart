import 'package:flutter/material.dart';

final class IVLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const IVLoader(this.isLoading, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}

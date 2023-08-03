import 'package:flutter/material.dart';

/// disposeを自動実行するWidget
class Disposable<T extends Object> extends StatefulWidget {
  const Disposable({
    Key? key,
    required this.create,
    required this.dispose,
    required this.build,
  }) : super(key: key);

  final T Function() create;
  final void Function(T target) dispose;
  final Widget Function(BuildContext context, T target) build;

  @override
  // ignore: library_private_types_in_public_api
  _DisposableState createState() => _DisposableState();
}

class _DisposableState<T extends Object> extends State<Disposable<T>> {
  late T target;

  @override
  void initState() {
    super.initState();
    target = widget.create();
  }

  @override
  void dispose() {
    widget.dispose(target);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, target);
  }
}

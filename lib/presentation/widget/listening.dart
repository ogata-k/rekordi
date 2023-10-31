import 'package:flutter/widgets.dart';

typedef ListeningWidgetBuilder<L extends Listenable> = Widget Function(
    BuildContext context, L listening, Widget? child);

/// listeningで指定されたValueNotifierやChangeNotifierを監視してリビルドを呼び出すWidget
class ListeningWidget<L extends Listenable> extends StatelessWidget {
  const ListeningWidget({
    super.key,
    required this.listening,
    required this.builder,
    this.child,
  });

  final L listening;
  final ListeningWidgetBuilder<L> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        key: key,
        listenable: listening,
        builder: (context, child) => builder(context, listening, child),
        child: child,
      );
}

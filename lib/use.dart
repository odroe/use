import 'package:flutter/widgets.dart';

typedef Element = Widget Function();
typedef Component = Element Function();

Element demo() {
  final state = useState(0);

  effect(() {
    print('Effect: ${state.value}');
  });

  return () => Text('Hello, World!');
}

import 'dart:async';

typedef Subscriber<T> = void Function(T state);
typedef Unsubscriber = void Function();
typedef Updater<T> = T Function(T state);
typedef StartStopNotifier<T> = void Function()? Function(
  void Function(T state) set,
  void Function(Updater<T> fn) update,
);
typedef Invalidate<T> = void Function([T? state]);

typedef Readable<T> = ({
  Unsubscriber Function(Subscriber<T> subscriber,
      [Invalidate<T>? invalidate]) subscribe,
});

typedef Writable<T> = ({
  void Function(T state) set,
  void Function(Updater<T> fn) update,
  Unsubscriber Function(Subscriber<T> subscriber,
      [Invalidate<T>? invalidate]) subscribe,
});

typedef _SubscribeInvalidateTuple<T> = ({
  Subscriber<T> subscriber,
  Invalidate<T> invalidate,
});

final _subscriberQueue = [];

Writable<T> writable<T>(T state, [StartStopNotifier<T>? start]) {
  Unsubscriber? stop;
  final subscribers = <_SubscribeInvalidateTuple<T>>{};

  void set(T newState) {
    if (state == newState) return;

    state = newState;
    if (stop is Unsubscriber) {
      for (final subscriber in subscribers) {
        subscriber.invalidate();
        _subscriberQueue.addAll([subscriber, state]);
      }
    }

    if (_subscriberQueue.isNotEmpty) {
      final queue = List.from(_subscriberQueue);
      _subscriberQueue.clear();
      for (var i = 0; i < queue.length; i += 2) {
        queue[i].subscriber(queue[i + 1]);
      }
    }
  }

  void update(Updater<T> fn) => set(fn(state));

  Unsubscriber subscribe(Subscriber<T> run, [Invalidate<T>? invalidate]) {
    final _SubscribeInvalidateTuple<T> subscriber = (
      subscriber: run,
      invalidate: invalidate ?? (([T? state]) {}),
    );
    subscribers.add(subscriber);

    if (subscribers.length == 1) {
      stop = start?.call(set, update) ?? () {};
    }

    run(state);

    return () {
      subscribers.remove(subscriber);
      if (subscribers.isEmpty && stop is Unsubscriber) {
        stop!();
        stop = null;
      }
    };
  }

  return (set: set, update: update, subscribe: subscribe);
}

Readable<T> readable<T>(T state, [StartStopNotifier<T>? start]) =>
    ((subscribe: writable(state, start).subscribe));

void main(List<String> args) {
  final StreamController<int> controller = StreamController<int>();

  controller.stream.listen((event) {
    print('event: $event');
  });

  final store = writable(0, (set, update) {
    controller.add(1);
    return () {
      controller.close();
    };
  });

  final unsubscribe = store.subscribe((state) {
    print('state: $state');
  });

  store.set(1);
  store.set(2);
  store.set(3);
  unsubscribe();

  final demo = (1, 2);
  Record;
}

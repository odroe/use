typedef Subscriber<T> = void Function(T state);
typedef Unsubscriber = void Function();
typedef Updater<T> = T Function(T state);
typedef Invalidator<T> = void Function(T? state);

abstract interface class Readable<T> {
  Unsubscriber subscribe(Subscriber<T> subscriber,
      [Invalidator<T>? invalidator]);
}

abstract interface class Writable<T> extends Readable<T> {
  void set(T state);
  void update(Updater<T> fn);
}

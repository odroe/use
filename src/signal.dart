abstract interface class Signal<T> {
  /// Returns the value of this signal.
  T get();
}

abstract interface class State<T> implements Signal<T> {
  /// Sets the value of this signal.
  void set(T value);
}

abstract interface class Computed<T> implements Signal<T> {}

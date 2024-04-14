extension type const Version(int epoch) implements int {
  /// Internal global epoch counter.
  static Version _epoch = const Version(1);

  /// Global epoch counter getter.
  static Version get current => Version._epoch;

  /// Increment the global epoch counter.
  static void increment() {
    _epoch = Version(_epoch + 1);
  }
}

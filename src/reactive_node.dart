import '_internal/version.dart';

abstract class ReactiveNode {
  /// Version of the value that this node produces.
  Version version;

  /// Epoch at which this node is verified to be clean.
  Version cleanAt;

  /// Whether this node (in its consumer capacity) is dirty.
  bool dirty;

  /// Producers which are dependencies of this consumer.
  Iterable<ReactiveNode> producers;

  /// `Version` of the value last read by a given producer.
  Iterable<Version> producerVersions;

  /// Index of `this` (consumer) in each producer's `liveConsumers` iterable.
  Iterable<int> producerIndices;

  /// Index into the producer arrays that the next dependency of this node as a
  /// consumer will use.
  int nextProducerIndex;

  /// Iterable of consumers of this producer that are "live" (they require push
  /// notifications).
  Iterable<ReactiveNode> liveConsumers;

  /// Index of `this` (producer) in each consumer's `producerNode` iterable.
  Iterable<int> consumerIndices;

  /// Whether writes to signals are allowed when this consumer is the
  /// `activeConsumer`.
  bool canWrite;

  /// Consumer is always live.
  final bool isLive;

  /// Tracks whether producers need to recompute their value independently of
  /// the reactive graph (for example, if no initial value has been computed).
  bool producersMustRecompute();
}

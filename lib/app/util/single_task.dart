import 'dart:async';

import 'loggable.dart';

/// Wraps a task that should only be executed one at a time.
class SingleInstanceTask<T> with Loggable {
  /// A unique identifier for this task, a matching task is what defines
  /// if it is running.
  final String name;

  /// The map of running tasks, if the name of this task is in this map
  /// it means it is running.
  ///
  /// The name maps to a [Completer] which will be notified when the logic
  /// has completed.
  static final _runningTasks = <String, Completer>{};

  SingleInstanceTask._(this.name);

  factory SingleInstanceTask.named(String name) => SingleInstanceTask._(name);

  /// Generate a named task based on the name of the class being passed into,
  /// this makes it cleaner to generate a [SingleInstanceTask] that matches
  /// the class you are currently working in.
  factory SingleInstanceTask.of(dynamic name) => SingleInstanceTask.named(
        name.runtimeType.toString(),
      );

  Future<T> run(Future<T> Function() task) async {
    if (_runningTasks.containsKey(name)) {
      logger.info('Unable to start [$name] as it is already running.');
      return _runningTasks[name]!.future as Future<T>;
    }

    final completer = Completer<T>();
    _runningTasks[name] = completer;

    try {
      final result = await task();
      completer.complete(result);
      return result;
    } finally {
      _runningTasks.remove(name);
    }
  }
}
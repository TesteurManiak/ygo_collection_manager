library worker;

import 'worker.dart'
    if (dart.library.io) 'worker_io.dart'
    if (dart.library.html) 'worker_web.dart';

abstract class BackgroundWorker {
  factory BackgroundWorker() => getWorker();
}

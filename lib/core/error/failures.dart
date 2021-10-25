abstract class Failure {
  const Failure();
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

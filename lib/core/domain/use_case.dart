import 'package:pixelcanvas/core/domain/result.dart';

/// Base contract for all application Use Cases per Blueprint §6.1.
///
/// **Purpose**: Encapsulates a single business logic operation.
/// **Parameters**:
/// - [Input]: Input parameters type.
/// - [Output]: Output result payload type.
abstract interface class UseCase<Input, Output> {
  /// Executes the usecase operation asynchronously.
  Future<Result<Output>> call(Input params);
}

/// Parameter object used when a Use Case requires no input parameters.
final class NoParams {
  /// Creates a [NoParams] instance.
  const NoParams();
}

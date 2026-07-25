import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/auth/domain/repositories/user_repository.dart';

/// Concrete Use Case terminating active user session per Blueprint §6.1.
class SignOut implements UseCase<NoParams, void> {
  /// Creates a [SignOut] usecase.
  const SignOut(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<void>> call(NoParams params) => _userRepository.signOut();
}

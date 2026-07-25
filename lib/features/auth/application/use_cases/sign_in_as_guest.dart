import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/auth/domain/entities/user.dart';
import 'package:pixelcanvas/features/auth/domain/repositories/user_repository.dart';

/// Concrete Use Case initializing offline guest mode session per Blueprint §6.1.
class SignInAsGuest implements UseCase<NoParams, User> {
  /// Creates a [SignInAsGuest] usecase.
  const SignInAsGuest(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<User>> call(NoParams params) => _userRepository.signInAsGuest();
}

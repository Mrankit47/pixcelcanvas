import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/auth/domain/entities/user.dart';
import 'package:pixelcanvas/features/auth/domain/repositories/user_repository.dart';

/// Concrete Use Case getting currently authenticated user session per Blueprint §6.1.
///
/// **Purpose**: Retrieves active user entity from storage or auth cache.
/// **Input**: [NoParams]
/// **Output**: [User] or null
/// **Failure Conditions**: Returns [StorageFailure] on local storage read failure.
/// **Future Sync Considerations**: Checks Supabase session validity in Phase 3 Step 5.
class GetCurrentUser implements UseCase<NoParams, User?> {
  /// Creates a [GetCurrentUser] usecase.
  const GetCurrentUser(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<User?>> call(NoParams params) => _userRepository.getCurrentUser();
}

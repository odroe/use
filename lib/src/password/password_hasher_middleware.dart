import 'package:spry/spry.dart';

import 'password_hasher.dart';

/// Password hasher middleware.
final class PasswordHasherMiddleware {
  /// Password hasher.
  final PasswordHasher passwordHasher;

  /// Create a password hasher middleware.
  const PasswordHasherMiddleware(this.passwordHasher);

  /// Spry middleware handler.
  Future call(Context context, Next next) async {
    context[PasswordHasher] = passwordHasher;

    return await next();
  }
}

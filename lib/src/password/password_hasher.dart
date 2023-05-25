import 'package:spry/spry.dart';

/// Password Hasher.
///
/// The [PasswordHasher] class provides methods for hashing and verifying
/// passwords.
interface class PasswordHasher {
  /// Generates a encodedPassword and salt from a password.
  (String encodedPassword, String salt) hash(String password) {
    throw UnimplementedError();
  }

  /// Verifies a password against a encodedPassword and salt.
  bool verify(String password, String encodedPassword, String salt) {
    throw UnimplementedError();
  }

  /// Resolve of the password hasher of the given [context].
  static PasswordHasher resolve(Context context) {
    return context[PasswordHasher] as PasswordHasher;
  }
}

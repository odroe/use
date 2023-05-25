import 'package:crypto/crypto.dart' as crypto show sha256;

import 'password_hasher.dart';

/// SHA256 password hasher.
final class Sha256PasswordHasher implements PasswordHasher {
  const Sha256PasswordHasher();

  @override
  (String, String) hash(String password) {
    final salt = crypto.sha256.convert(password.codeUnits).toString();
    final encodedPassword =
        crypto.sha256.convert((password + salt).codeUnits).toString();

    return (encodedPassword, salt);
  }

  @override
  bool verify(String password, String encodedPassword, String salt) {
    final newEncodedPassword =
        crypto.sha256.convert((password + salt).codeUnits).toString();

    return newEncodedPassword == encodedPassword;
  }
}

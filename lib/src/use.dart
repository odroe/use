import 'dart:io';

import 'package:spry/spry.dart';

import 'password/password_hasher.dart';
import 'password/password_hasher_middleware.dart';
import 'password/sha256_password_hasher.dart';
import 'routes.dart';

/// Create a Use application for `dart:io` HTTP server handler.
Future<void> Function(HttpRequest) use({
  PasswordHasher passwordHasher = const Sha256PasswordHasher(),
}) {
  final spry = Spry();

  // Add the password hasher to the context.
  spry.use(PasswordHasherMiddleware(passwordHasher));

  return spry(createUseRouter());
}

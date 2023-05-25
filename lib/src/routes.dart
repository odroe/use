import 'package:spry/router.dart';

import 'oauth/server/routes.dart';

/// Create a Use application root router.
Router createUseRouter() {
  final router = Router();

  // Mount the OAuth server router.
  router.mount('/auth/oauth', router: createOAuthServerRouter());

  return router;
}

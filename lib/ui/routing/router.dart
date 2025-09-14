import 'package:b1_first_flutter_app/provider/auth_state.dart';
import 'package:b1_first_flutter_app/ui/routing/auth_routes.dart';
import 'package:b1_first_flutter_app/ui/routing/home_routes.dart';
import 'package:b1_first_flutter_app/ui/routing/setting_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter{
  AppRouter._(this.router);

  static AppRouter? _instance;

  final GoRouter router;

  static AppRouter getInstance(AuthProvider authProvider) {
    _instance ??= AppRouter._(_createRouter(authProvider));
    return _instance!;
  }

  static GoRouter _createRouter(AuthProvider authProvider) {
    return GoRouter(
      refreshListenable: authProvider,
      initialLocation: '/',
      routes: [ 
        ...AuthRoutes.routes,
        ...HomeRoutes.routes,
        ...SettingsRoutes.routes,
      ],
      redirect: (context, state) {
        final bool loggedIn = authProvider.isLoggedIn;
        final bool loggingIn = state.matchedLocation == '/login';

        if (!loggedIn && !loggingIn) return '/login?from=${state.matchedLocation}';
        print(state.uri.queryParameters['from']??'/');
        if (loggedIn && loggingIn) return state.uri.queryParameters['from']??'/';
        return null;
      },
    );
  }
}
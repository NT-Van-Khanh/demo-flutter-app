import 'package:b1_first_flutter_app/ui/page/login_page.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static const login = 'login';
  static List<GoRoute> routes = [
    GoRoute(
      path: '/login',
      name: login,
      builder: (context, state) => const LoginPage(),
    ),
  ];
}
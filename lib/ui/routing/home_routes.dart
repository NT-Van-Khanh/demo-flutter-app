import 'package:b1_first_flutter_app/ui/page/favorites_page.dart';
import 'package:b1_first_flutter_app/ui/page/my_home_page.dart';
import 'package:b1_first_flutter_app/ui/page/weather/weather_page.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes{
  static List<GoRoute> routes = [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => MyHomePage(),
      routes: [
        GoRoute(
          path: 'favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(
          path: 'weather',
          name: 'weather',
          builder: (context, state) => const WeatherPage(),
        ),
      ],
    ),
  ];
}
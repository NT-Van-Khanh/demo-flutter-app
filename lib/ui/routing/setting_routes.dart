import 'package:b1_first_flutter_app/ui/page/animation/animation_page.dart';
import 'package:b1_first_flutter_app/ui/page/audio/audio_playback_page.dart';
import 'package:b1_first_flutter_app/ui/page/button_page.dart';
import 'package:b1_first_flutter_app/ui/page/calendar_page.dart';
import 'package:b1_first_flutter_app/ui/page/countdown_timer_page.dart';
import 'package:b1_first_flutter_app/ui/page/empty_page.dart';
import 'package:b1_first_flutter_app/ui/page/input_page.dart';
import 'package:b1_first_flutter_app/ui/page/settings_page.dart';
import 'package:b1_first_flutter_app/ui/page/theme_page.dart';
import 'package:b1_first_flutter_app/ui/page/todo_list_page.dart';
import 'package:go_router/go_router.dart';

class SettingsRoutes {
  static const ROOT = 'settings';
  static const THEME = 'theme';
  static const AUDIO = 'audio';
  static const COUNTDOWN = 'countdown';
  static const TODO = 'todo';
  static const CALENDAR = 'calendar';
  static const INPUT = 'input';
  static const LAYOUT = 'layout';
  static const BUTTON = 'button';
  static const ANIMATION = 'animation';
  static const FONT_SIZE = 'fontSize';
  static const SECURITY = 'security';

  static List<GoRoute> routes = [
    GoRoute(
      path: '/settings',
      name: ROOT,
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: 'theme',
          name: THEME,
          builder: (context, state) => const ThemePage(),
        ),
        GoRoute(
          path: 'audio',
          name: AUDIO,
          builder: (context, state) => AudioPlaybackPage(),
        ),
        GoRoute(
          path: 'countdown',
          name: COUNTDOWN,
          builder: (context, state) => CountdownTimerPage(),
        ),
        GoRoute(
          path: 'todo',
          name: TODO,
          builder: (context, state) => TodoListPage(),
        ),
        GoRoute(
          path: 'calendar',
          name: CALENDAR,
          builder: (context, state) => CalendarPage(),
        ),
        GoRoute(
          path: 'input',
          name: INPUT,
          builder: (context, state) => InputPage(),
        ),
        GoRoute(
          path: 'layout',
          name: LAYOUT,
          builder: (context, state) => const EmptyPage(),
        ),
        GoRoute(
          path: 'button',
          name: BUTTON,
          builder: (context, state) => ButtonPage(),
        ),
        GoRoute(
          path: 'animation',
          name: ANIMATION,
          builder: (context, state) => AnimationPage(),
        ),
        GoRoute(
          path: 'font-size',
          name: FONT_SIZE,
          builder: (context, state) => const EmptyPage(),
        ),
        GoRoute(
          path: 'security',
          name: SECURITY,
          builder: (context, state) => const EmptyPage(),
        ),
      ],
    ),
  ];
}
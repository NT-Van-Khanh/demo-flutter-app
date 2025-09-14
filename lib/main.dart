import 'package:b1_first_flutter_app/provider/music_playback_state.dart';
import 'package:b1_first_flutter_app/provider/weather_state.dart';
import 'package:b1_first_flutter_app/provider/auth_state.dart';
import 'package:b1_first_flutter_app/provider/my_app_state.dart';
import 'package:b1_first_flutter_app/ui/routing/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'as riverpod;
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final appState = MyAppState();
  final authState = AuthProvider();
  await appState.loadPrefs();
  await authState.loadLoginStatus();
   tz.initializeTimeZones();

  tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  runApp(
     riverpod.ProviderScope(
       child: MultiProvider(
        providers: [
            ChangeNotifierProvider( create: (_) => appState),
            ChangeNotifierProvider(create: (_) => authState),
            ChangeNotifierProvider(create: (_)=> WeatherState()),
            ChangeNotifierProvider(create: (_) => MusicPlaybackState())
          ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,) {
    final appState = Provider.of<MyAppState>(context);
    final authState = Provider.of<AuthProvider>(context);
    final router = AppRouter.getInstance(authState).router;

    return MaterialApp.router(
        title: 'Namer App',
        locale: appState.locale,
        routerConfig: router,
        // home:  authState.isLoggedIn ? MyHomePage() : const LoginPage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.light,),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue,  brightness: Brightness.dark, ),
        ),
        themeMode: appState.appThemeMode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
    );
  }
}


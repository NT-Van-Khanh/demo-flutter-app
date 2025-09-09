import 'package:b1_first_flutter_app/provider/music_playback_state.dart';
import 'package:b1_first_flutter_app/provider/weather_state.dart';
import 'package:b1_first_flutter_app/ui/page/favorites_page.dart';
import 'package:b1_first_flutter_app/ui/page/generator/generator_page.dart';
import 'package:b1_first_flutter_app/ui/page/login_page.dart';
import 'package:b1_first_flutter_app/ui/page/settings_page.dart';
import 'package:b1_first_flutter_app/ui/page/weather_page.dart';
import 'package:b1_first_flutter_app/provider/auth_state.dart';
import 'package:b1_first_flutter_app/provider/my_app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'as riverpod;
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appState = MyAppState();
  final authState = AuthProvider();
  await appState.loadPrefs();
  await authState.loadLoginStatus();
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
    return MaterialApp(
            title: 'Namer App',
            locale: appState.locale,
            home:  authState.isLoggedIn ? MyHomePage() : LoginPage(),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.light,),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.lightBlue,
                  brightness: Brightness.dark,
                  ),
            ),
            themeMode: appState.appThemeMode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
          );
  }
}

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(selectedIndex){
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritesPage();
      case 3:
        page = SettingsPage();
      case 2:
        page = WeatherPage();
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }
    
    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    
    var bottomNavigationBarItem = [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppLocalizations.of(context)!.home),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: AppLocalizations.of(context)!.favorites),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloudy_snowing),
          label: AppLocalizations.of(context)!.weather),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.settings),
    ];

    var navigationRailDestinations = [ 
      NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text(AppLocalizations.of(context)!.home),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text(AppLocalizations.of(context)!.favorites),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.cloud),
        label: Text(AppLocalizations.of(context)!.weather),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.settings), 
        label: Text(AppLocalizations.of(context)!.settings)
      ),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < 450){
              return Column(
                  children: [
                    Expanded(child: mainArea),
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      iconSize: 28,
                      elevation: 20,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      selectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ) ,
                      unselectedFontSize: 12,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      unselectedItemColor: Theme.of(context).colorScheme.secondary,
                      items: bottomNavigationBarItem,
                      currentIndex: selectedIndex,
                      onTap: (value) {  setState(() => selectedIndex = value);},
                    ),
                  ],
              );
          }else{
            return Row(
                children: [
                  SafeArea(
                    child: NavigationRail(
                      extended: constraints.maxWidth>=600,
                      destinations: navigationRailDestinations,
                      selectedIndex: selectedIndex,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      onDestinationSelected: (value) {setState(() => selectedIndex = value);},
                      labelType: constraints.maxWidth < 600
                            ? NavigationRailLabelType.selected // nhỏ thì chỉ hiện chữ khi chọn
                            : NavigationRailLabelType.none,
                    ),
                  ),
                  Expanded(child: mainArea),
                ],
            );
          }
        }
      ),
    );
  }
}

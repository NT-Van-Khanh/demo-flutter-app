import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:b1_first_flutter_app/data/model/bar_item.dart';
import 'package:b1_first_flutter_app/ui/page/favorites_page.dart';
import 'package:b1_first_flutter_app/ui/page/generator/generator_page.dart';
import 'package:b1_first_flutter_app/ui/page/settings_page.dart';
import 'package:b1_first_flutter_app/ui/page/weather/weather_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  var count=0;
  var selectedIndex = 0;
  List<BarItem>? _cachedMenuItems;
  List<BottomNavigationBarItem>?  _cacheBottomNavBarItems;
  List<NavigationRailDestination>? _cacheNavRailItems;
    
  Locale? _currentLocale;
  
  @override
  Widget build(BuildContext context) {
    final colorScheme =Theme.of(context).colorScheme;
    final locale =Localizations.localeOf(context);
    print('Main: ${++count}');
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

    if (_cachedMenuItems == null || _currentLocale != locale) {
      _currentLocale = locale;
      _cachedMenuItems= [
        BarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.home),
        BarItem(icon: Icon(Icons.favorite), label:AppLocalizations.of(context)!.favorites),
        BarItem(icon: Icon(Icons.cloudy_snowing), label: AppLocalizations.of(context)!.home),
        BarItem(icon: Icon(Icons.settings), label: AppLocalizations.of(context)!.settings),
      ];
    }
    var mainArea = ColoredBox(
      color: colorScheme.primaryContainer,
      child: AnimatedSwitcher( duration: Duration(milliseconds: 200), child: page,),
    );
    
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < 450){
              initBottomNavBarItems();
              return Column(
                  children: [
                    Expanded(child: mainArea),
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      iconSize: 28,
                      elevation: 20,
                      backgroundColor: colorScheme.surfaceContainerLow,
                      selectedItemColor: colorScheme.primary,
                      selectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ) ,
                      unselectedFontSize: 12,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      unselectedItemColor: colorScheme.secondary,
                      items: _cacheBottomNavBarItems!,
                      currentIndex: selectedIndex,
                      onTap: (value) {  setState(() => selectedIndex = value);},
                    ),
                  ],
              );
          }else{
            initNavRailItems();
            return Row(
                children: [
                  SafeArea(
                    child: NavigationRail(
                      extended: constraints.maxWidth>=600,
                      destinations: _cacheNavRailItems!,
                      selectedIndex: selectedIndex,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      onDestinationSelected: (value) {setState(() => selectedIndex = value);},
                      labelType: constraints.maxWidth < 600
                            ? NavigationRailLabelType.selected 
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

  void initBottomNavBarItems() {
    if(_cacheBottomNavBarItems == null){
       print("Main: Init Bottom Bar Items run...");
      List<BottomNavigationBarItem> bottmBarItems =[];
      for (var item in _cachedMenuItems!){
        bottmBarItems.add(BottomNavigationBarItem( icon: item.icon, label: item.label));
      }
      _cacheBottomNavBarItems = bottmBarItems;
    }
  }

  void initNavRailItems() {
    if(_cacheNavRailItems == null){
       print("Main: Init Nav Rail Items run...");
      List<NavigationRailDestination> navRailItems =[];
      for (var item in _cachedMenuItems!){
        navRailItems.add(NavigationRailDestination( icon: item.icon, label: Text(item.label)));
      }
      _cacheNavRailItems = navRailItems;
    }
  }
}


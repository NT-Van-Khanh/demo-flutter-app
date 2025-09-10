import 'package:b1_first_flutter_app/data/enum/language.dart';
import 'package:b1_first_flutter_app/data/model/setting_item.dart';
import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:b1_first_flutter_app/ui/page/animation/animation_page.dart';
import 'package:b1_first_flutter_app/ui/page/button_page.dart';
import 'package:b1_first_flutter_app/ui/page/calendar_page.dart';
import 'package:b1_first_flutter_app/ui/page/countdown_timer_page.dart';
import 'package:b1_first_flutter_app/ui/page/input_page.dart';
import 'package:b1_first_flutter_app/ui/page/audio/audio_playback_page.dart';
import 'package:b1_first_flutter_app/ui/page/todo_list_page.dart';
import 'package:b1_first_flutter_app/provider/auth_state.dart';
import 'package:b1_first_flutter_app/provider/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLoc =  AppLocalizations.of(context)!;
    var authState = context.watch<AuthProvider>();
    var settingItems = [
      SettingItem(
        title: appLoc.fontSize,
        icon: Icons.format_size,
      ),
      SettingItem(
        title: appLoc.security,
        icon: Icons.security,
      ),
    ];

    var featureItems = [
      SettingItem(
        title: appLoc.information,
        icon: Icons.person,
      ),
      SettingItem(
        title: appLoc.playAudio,
        icon: Icons.my_library_music,
        widget: AudioPlaybackPage(),
      ),
      SettingItem(
        title: appLoc.countdownTimer,
        icon: Icons.alarm,
        widget: CountdownTimerPage(),
      ),
      SettingItem(
        title: "Todo List",
        icon: Icons.check_box,
        widget: TodoListPage(),
      ),
      SettingItem(
        title: appLoc.calendar,
        icon: Icons.calendar_month_outlined,
        widget: CalendarPage(),
      ),
      
      SettingItem(
        title: "Test Input",
        icon: Icons.input_outlined,
        widget: InputPage(),
      ),

      SettingItem(
        title: "Test Layout",
        icon: Icons.layers_outlined,
      ),
      SettingItem(
        title: "Test Button",
        icon: Icons.layers_outlined,
        widget: ButtonPage(),
      ),
      
      SettingItem(
        title: "Test Animation",
        icon: Icons.category,
        widget: AnimationPage(),
      ),
    ];


    return  Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings,
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: ()=>{authState.logout()}, 
                icon: Icon(Icons.logout)),
              // Text("Logout",
              // style: TextStyle(
              //   fontWeight: FontWeight.w500,
              // ),),
              // SizedBox(width: 20,)
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              FeatureCard(featureItems: featureItems),
              SettingCard(settingItems: settingItems),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingCard extends StatefulWidget {
  const SettingCard({
    super.key,
    required this.settingItems,
  });

  final List<SettingItem> settingItems;

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  @override
  Widget build(BuildContext context) {
    var appState =context.watch<MyAppState>();
    bool isDarkMode = appState.appThemeMode.isDarkMode;
    
    return Card(
      // color: Theme.of(context).colorScheme.secondaryContainer,
      shadowColor: Colors.white30,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 12.0, left: 12.0, right: 12.0),
            //  padding: const EdgeInsets.symmetric(horizontal:  12.0, vertical: 12.0),
           
            child: SizedBox(
              width: double.infinity,
              child: Text(AppLocalizations.of(context)!.settings,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                    leading: Icon(Icons.brightness_4),
                    title: Text('${AppLocalizations.of(context)!.theme}: ${isDarkMode 
                          ? AppLocalizations.of(context)!.darkTheme 
                          : AppLocalizations.of(context)!.lightTheme}',
                    ),
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isDarkMode,
                        activeThumbColor: Theme.of(context).colorScheme.primary,
                        inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                        thumbIcon: WidgetStateProperty.all<Icon?>(
                          Icon(Icons.brightness_4),
                        ),
                        onChanged: (value) => appState.setThemeMode(value),
                      ),
                    ),
                    textColor: Theme.of(context).colorScheme.onSurface,
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ListTileLanguage(mounted: mounted),
                for(final item in widget.settingItems)
                  ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    textColor: Theme.of(context).colorScheme.onSurface,
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                    ),
                    onTap: ()=> Navigator.push( context,
                          MaterialPageRoute( builder: (context) => item.widget,),
                      ),
                  ),
                ],
            ),
          )
        ],
      ),
    );
  }
}

class ListTileLanguage extends StatefulWidget {
  const ListTileLanguage({
    super.key,
    required this.mounted,
  });

  final bool mounted;

  @override
  State<ListTileLanguage> createState() => _ListTileLanguageState();
}

class _ListTileLanguageState extends State<ListTileLanguage> {
  Future<void> _showLanguageMenu(BuildContext context) async {
    final appState = context.read<MyAppState>();
    final langEnglish = AppLocalizations.of(context)!.langEnglish;
    final langVietnamese = AppLocalizations.of(context)!.langVietnamese;

    final RenderBox tileBox = context.findRenderObject() as RenderBox;
    final Offset position = tileBox.localToGlobal(Offset.zero);

    final selected = await showMenu<Language>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + tileBox.size.height,
        position.dx + tileBox.size.width,
        0,
      ),
      items: [
        PopupMenuItem(value: Language.EN, 
          child: SizedBox(
            width: 200,
            child: Text(langEnglish,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ),
        PopupMenuItem(value: Language.VI,
          child: SizedBox(
            width: 200,
            child: Text(langVietnamese,
            style: TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ),
      ],
    );

    if (!widget.mounted) return; // kiểm tra widget còn attach
    if (selected != null) {
      appState.setLocale(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
      
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text('${AppLocalizations.of(context)!.language} : ${AppLocalizations.of(context)!.currentLanguage}'),
      textColor: Theme.of(context).colorScheme.onSurface,
      titleTextStyle: TextStyle(fontSize: 18,),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () => _showLanguageMenu(context),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.featureItems,
  });

  final List<SettingItem> featureItems;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Theme.of(context).colorScheme.secondaryContainer,
      shadowColor: Colors.white30,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 12.0, left: 12.0, right: 12.0),
           
            // padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0,),
            child: SizedBox(
              width: double.infinity,
              child: Text(AppLocalizations.of(context)!.features,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: featureItems.length,
              itemBuilder: (context, index) {                    
                final item = featureItems[index];
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  textColor: Theme.of(context).colorScheme.onSurface,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                  ),
                  onTap: ()=> Navigator.push( context,
                        MaterialPageRoute( builder: (context) => item.widget,),
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

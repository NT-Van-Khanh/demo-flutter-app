import 'package:b1_first_flutter_app/provider/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    var appState =context.watch<MyAppState>();
    bool isDarkMode = appState.appThemeMode.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text("Empty Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isDarkMode ? "Dark Theme" : "Light Theme",style: Theme.of(context).textTheme.titleMedium,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: isDarkMode, 
                            activeThumbColor: Theme.of(context).colorScheme.primary,  
                            inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                            thumbIcon: WidgetStateProperty.all<Icon?>(Icon(Icons.brightness_4)),
                            onChanged: (value) => appState.setThemeMode(value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Text("This is the empty page."),
            ],
          ),
        ),
      ),
    );
  }
}
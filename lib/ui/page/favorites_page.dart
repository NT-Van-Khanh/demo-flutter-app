import 'package:b1_first_flutter_app/provider/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    if(appState.favorites.isEmpty){
      return Center(
        child: Text("No favarites yet"),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox( height: 65, ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(16), // bo góc 16 pixel
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text('You have '
                      '${appState.favorites.length} favorites',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  
                ),
                Expanded(
                  child: GridView(
                    gridDelegate: 
                    constraints.maxWidth <450 ?
                      SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        childAspectRatio: 400/100,):
                      SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 300/70,),
                    shrinkWrap: true,
                    children: [
                    
                    for (var pair in appState.favorites) 
                        ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.delete, semanticLabel: 'Delete'),
                            color: theme.colorScheme.primary,
                            onPressed: () { appState.removeFavorite(pair);},
                          ),
                          tileColor: Colors.amber,
                          textColor: Colors.brown[500],
                          title: 
                            Text(pair.asLowerCase,
                              semanticsLabel: pair.asPascalCase,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),    
                        )
                    ],
                  ),
                ),
            ],
          )
        );
      }
    );
  }
}

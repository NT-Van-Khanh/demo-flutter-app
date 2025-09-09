import 'package:b1_first_flutter_app/provider/my_app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HistoriyListView extends StatefulWidget {
  const HistoriyListView({super.key});

  @override
  State <HistoriyListView> createState() =>  _HistoriyListViewState();
}

class _HistoriyListViewState extends State<HistoriyListView> {
  final _key =GlobalKey();
  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _gradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback:(bounds) => _gradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: EdgeInsets.only(top:100),
        initialItemCount: appState.histories.length,
        itemBuilder: (context, index, animation) {
            final pair = appState.histories[index];
            return SizeTransition(
              sizeFactor: animation,
              child: Center(
                child: TextButton.icon(
                  onPressed: () => appState.toggleFavorite(),
                  icon: appState.favorites.contains(pair) ? 
                        Icon(Icons.favorite, size: 12,):
                        SizedBox(),
                  label: Text(
                        pair.asLowerCase,
                        semanticsLabel: pair.asPascalCase,)
                ),
              ), 
            );
        }
      ),
      );
  }
}
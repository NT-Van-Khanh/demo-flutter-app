import 'package:flutter/material.dart';

class AudioControlBar extends StatelessWidget {
  const AudioControlBar({
    super.key,
    required this.isPause,
    required this.onPlayPause,
    this.onNext,
    this.onPrevious,
  });

  final bool isPause;
  final VoidCallback onPlayPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        IconButton(
          iconSize: 56,
          onPressed: onPrevious,
          icon: Icon(Icons.skip_previous_rounded)),
        SizedBox(width: 3,),
        IconButton(
          iconSize: 64,
          onPressed: onPlayPause,
          icon: isPause ? Icon(Icons.play_circle_outline):Icon(Icons.pause_circle_outline_rounded)
          ),
        SizedBox(width: 3,),
        IconButton(
          iconSize: 56,
          onPressed: onNext,
          icon: Icon(Icons.skip_next_rounded)),
        Spacer(),
      ],
    );
  }
}

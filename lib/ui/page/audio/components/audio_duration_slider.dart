import 'package:b1_first_flutter_app/provider/music_playback_state.dart';
import 'package:b1_first_flutter_app/util/local_datetime.dart';
import 'package:flutter/material.dart';

class AudioDurationSlider extends StatelessWidget {
  const AudioDurationSlider({
    super.key,
    required this.musicPlaybackState,
    required double duration,
  }) : _timePlay = duration;

  final MusicPlaybackState musicPlaybackState;
  final double _timePlay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(left:18.0),
            child: Text(LocalDatetime.parseToMinutesSeconds(musicPlaybackState.duration)),
          ),
        Spacer(),
          Padding(
            padding: const EdgeInsets.only(right:18.0),
            child: Text(LocalDatetime.parseToMinutesSeconds(_timePlay)),
          ),
      ]
    );
  }
}

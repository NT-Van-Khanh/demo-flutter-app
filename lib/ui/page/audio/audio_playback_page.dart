import 'dart:async';

import 'package:b1_first_flutter_app/provider/music_playback_state.dart';
import 'package:b1_first_flutter_app/ui/page/audio/components/audio_control_bar.dart';
import 'package:b1_first_flutter_app/ui/page/audio/components/audio_duration_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioPlaybackPage extends StatefulWidget {
  const AudioPlaybackPage({super.key});

  @override
  State<AudioPlaybackPage> createState() => _AudioPlaybackPageState();
}

class _AudioPlaybackPageState extends State<AudioPlaybackPage> {
  bool isStop = true;
  final player = AudioPlayer();
  StreamSubscription<Duration>? _positionSub;
  double _duration = 0;
  String _audioTitle = "Audio Title";

  Future<void> initAudioFromAsset(String url) async{
    try {
      Duration duration =await player.setAsset(url) ?? Duration.zero;
      _duration = duration.inSeconds.toDouble();
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('Stack: $st');
    }
  }

  Future<void> initAudioFromUrl(String url) async {
    try {
      await player.setUrl(url);
      if (player.processingState == ProcessingState.ready) {
        _duration = player.duration?.inSeconds.toDouble() ?? 0;
        debugPrint('Player ready. Duration: $_duration s');
      } else {
        debugPrint('Player chưa sẵn sàng, processingState: ${player.processingState}');
      }
    } catch (e, st) {
      debugPrint('Error: $e');
      debugPrint('Stack: $st');
    }
  }

  void runAudio(MusicPlaybackState state) async {
    if (player.playing || player.processingState == ProcessingState.ready) {
        player.play();
      _positionSub?.cancel();
      _positionSub = player.positionStream.listen((position) {
        final seconds = position.inSeconds.toDouble();
          if (seconds <= _duration) {
            state.changeMusicTimeLine(seconds);
          }
        }
      );
    } else {
      debugPrint('Player chưa sẵn sàng để play');
    }
  }

  void stopMusic() async {
    print("Before pause");
    await player.pause();
    print("Pause.");
    _positionSub?.cancel();
    _positionSub = null;
  }

  @override
  void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initAudioFromAsset('assets/audio/file_example_MP3_700KB.mp3');
      print("Duration: ${player.duration}");
      setState(() {}); 
    });
  }

  @override
  void dispose() {
    stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final musicPlaybackState = context.watch<MusicPlaybackState>();

    void changePlayAudio() {
      final wasPlaying = !isStop;
      setState(() { isStop = !isStop;});
      if (wasPlaying) {
        stopMusic();
      } else {
        runAudio(musicPlaybackState);
      }
    }

    void seekAudio(int value) {
      player.seek(Duration(seconds: value));
      runAudio(musicPlaybackState);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Music"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              AudioTitleText(audioTitle: _audioTitle),
              SizedBox(height: 50,),
              AudioIcon(),
              SizedBox(height: 30,),
              AudioDurationSlider(
                  musicPlaybackState: musicPlaybackState,
                  duration: _duration),
              SizedBox(
                height: 24,
                child: Slider(
                  value: musicPlaybackState.duration.clamp(0.0, _duration),
                  min: 0,
                  max: _duration,
                  onChangeStart: (_) => stopMusic(),
                  onChanged: (value) => musicPlaybackState.changeMusicTimeLine(value),
                  onChangeEnd:  (value) => seekAudio(value.toInt()),
                  ),
                ),
              SizedBox(height: 18,),
              AudioControlBar(
                isPause: isStop,
                onPlayPause: changePlayAudio,
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Icon(Icons.table_rows_rounded,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,),
                    ),
                    Expanded(
                        child: Text("List audio",
                        style: TextStyle(fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 22),
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: musicPlaybackState.audios.length,
                    itemBuilder: (context, index) {
                      final audioUrl = musicPlaybackState.audios[index];
                      return ListTile(
                        leading: Icon(Icons.audiotrack),
                        title: Text('Audio ${index + 1}'),
                        subtitle: Text(audioUrl.split('/').last),
                        selected: index == musicPlaybackState.currentIndex,
                        onTap: () async {
                          isStop = true;
                          stopMusic();
                          musicPlaybackState.setAudioTrack(index);
                          await initAudioFromUrl(audioUrl);
                          musicPlaybackState.changeMusicTimeLine(0);
                          runAudio(musicPlaybackState);
                          isStop = false;
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AudioIcon extends StatelessWidget {
  const AudioIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
          "assets/images/dvd_playing.png",
          width: 260,
          height: 260,
          ),
    );
  }
}

class AudioTitleText extends StatelessWidget {
  const AudioTitleText({
    super.key,
    required String audioTitle,
  }) : _songTitle = audioTitle;

  final String _songTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Text(_songTitle,
       style: TextStyle(
        fontWeight: FontWeight.w900,
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 28,
       ),),
    );
  }
}

   
   

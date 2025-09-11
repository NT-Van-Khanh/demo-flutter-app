import 'package:flutter/material.dart';

class MusicPlaybackState extends ChangeNotifier{
  double _duration = 0;
  double _volume= 50;
  var _audios = <String>[
    'https://ia600208.us.archive.org/7/items/adventures_holmes/adventureholmes_01_doyle.mp3',
    'https://ia600208.us.archive.org/7/items/adventures_holmes/adventureholmes_02_doyle.mp3',
    'https://ia600208.us.archive.org/7/items/adventures_holmes/adventureholmes_03_doyle.mp3',
    'https://ia600208.us.archive.org/7/items/adventures_holmes/adventureholmes_05_doyle.mp3',
  ];

  int _currentIndex = 0;

  double get duration => _duration;
  double get volume => _volume;
  List<String> get audios => _audios;
  int get currentIndex => _currentIndex;



  void setAudioTrack(int index) {
    if (index >= 0 && index < _audios.length) {
      _currentIndex = index;
      _duration = 0;
      notifyListeners();
    }
  }
  void changeVolume(double value){
    _volume= value;
    notifyListeners();
  }

  void changeMusicTimeLine(double value){
    _duration = value;
    notifyListeners();
  }

}
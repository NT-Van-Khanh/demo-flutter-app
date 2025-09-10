import 'dart:async';

import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:b1_first_flutter_app/util/local_datetime.dart';
import 'package:b1_first_flutter_app/util/local_notifications.dart';
import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {

  const CountdownTimerPage({super.key});

  @override
  State<CountdownTimerPage> createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  bool isPlay = false;
  int _duration = 5;
  Icon iconPlay = Icon(Icons.play_circle_fill_rounded);
  Icon iconStop = Icon(Icons.stop_circle_rounded);
  Timer? timer;

   void runCountdown() async{
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 1), (t) {
        setState(() {
          if (_duration>0) {      
            _duration -=1;
          } else {
            t.cancel();
            timer = null;
            isPlay = false;
            resetDuration();
            LocalNotifications.showNotification();
          } 
        });
      });
    }

    void resetDuration(){
      _duration= 5;
    }

    void stopCountdown() async{
      timer?.cancel();  
      timer = null; 
      resetDuration();
    }

    void buttonToggle(){
      setState(() {
        isPlay=!isPlay;
        if(isPlay){
          runCountdown();
        }else{
          stopCountdown();
        }
      });
    }

  @override
  void initState() {
    super.initState();
    LocalNotifications.initNotifications();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLoc.countdownTimer, style: TextStyle(
              color:colorScheme.secondary,
              fontWeight: FontWeight.w500,),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text("This is not a empty page.",
            style: TextStyle(
              color:colorScheme.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 10,),
            Text(LocalDatetime.parseToHourMinutesSeconds(_duration),
            style: TextStyle(
              color:colorScheme.secondary,
              fontSize: 62,
              fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 10,),
            IconButton(
              onPressed:buttonToggle, 
              icon: isPlay ? iconStop : iconPlay,
              iconSize: 64,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
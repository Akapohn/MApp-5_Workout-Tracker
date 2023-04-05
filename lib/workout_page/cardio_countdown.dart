import 'dart:async';
import 'package:flutter/material.dart';

class CardioCountdown extends StatefulWidget {
  int time;
  CardioCountdown({super.key, required this.time});

  @override
  State<CardioCountdown> createState() => _CardioCountdown();
}

class _CardioCountdown extends State<CardioCountdown> {
  Timer? timer;
  bool stop = true;
  bool runing = false;
  int seconds = 0;
  int restoreTime = 0;

  void stopTimer({bool reset = true}) {
    if (reset) {
      if (seconds + restoreTime >= 60) {
        setState(() {
          widget.time++;
        });
        seconds += (restoreTime - 60);
      } else {
        setState(() {
          seconds += restoreTime;
        });
      }
      restoreTime = 0;
    }
    timer?.cancel();
  }

  bool changeState() {
    setState(() {
      stop = !stop;
    });
    return stop;
  }

  Widget timerWidget() {
    var min = widget.time;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Reset btn
        IconButton(
            onPressed: () {
              setState(() {
                stop = true;
              });
              stopTimer(reset: true);
            },
            icon: const Icon(Icons.restore)),
        // Time Text
        Text("${widget.time} : $seconds", style: const TextStyle(fontSize: 60)),
        // Play and Pause Btn
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (stop) {
                timer = Timer.periodic(const Duration(seconds: 1), (_) {
                  if (seconds > 0) {
                    setState(() {
                      seconds--;
                      restoreTime++;
                    });
                  } else if (min > 0) {
                    setState(() {
                      widget.time--;
                      restoreTime++;
                      seconds = 59;
                    });
                  } else {
                    stopTimer();
                  }
                });
              } else {
                stopTimer(reset: false);
              }
              changeState();
            },
            icon: Icon(
              stop ? Icons.play_arrow : Icons.pause,
              size: 50,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return timerWidget();
  }
}

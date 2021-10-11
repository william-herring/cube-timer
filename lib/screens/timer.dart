import 'dart:io';
import 'package:cube_timer/main.dart';
import 'package:cube_timer/scramblers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  TimerScreen.periodic(Duration oneSec, Null Function(TimerScreen timer) param1);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  var time;
  var duration = Duration();
  var readyState;
  bool timing = false;
  IconData enterTimeIcon = Icons.touch_app_rounded;
  var enterTimeMode = 0;
  bool enteringTime = false;
  Color timerColor = Colors.white;
  String scramble = generateRandom333();
  Timer? timer;

  void initState() {
    super.initState();
    time = 0.00;
    readyState = "not ready";
    scramble = generateRandom333();
  }

  void stopTimer() {
    setState(() => timer?.cancel());
  }

  void resetTimer() {
    setState(() => duration = Duration());
  }

  void addTime() {
    final addTime = 10;

    setState(() {
      final milliseconds = duration.inMilliseconds + addTime;

      duration = Duration(milliseconds: milliseconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 10), (t) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (timing) {
          stopTimer();
          setState(() {
            scramble = generateRandom333();
          });
        }

        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
        }
      },

      onHorizontalDragStart: (DragStartDetails) {
        setState(() {
          scramble = generateRandom333();
        });
      },

      onDoubleTap: () {

      },

      onLongPressStart: (LongPressStartDetails details) { setState(() {
        readyState = "ready";
        timerColor = Color.fromRGBO(45, 163, 101, 1.0);
      });
      },

      onLongPressEnd: (LongPressEndDetails details) { setState(() {
        readyState = "solving";
        timerColor = Colors.white;

        setState(() {
          resetTimer();
          startTimer();
          timing = true;
        });
      });
      },

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(19, 19, 19, 1.0),
          elevation: 0,
          leading:
            Container(
              margin: EdgeInsets.only(left: 12),
              width: 200,

              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Color.fromRGBO(50, 50, 50, 1.0),
              ),

              child: IconButton(icon: Icon(enterTimeIcon), color: Colors.white, onPressed: () {
                _showInputPicker(context);
              }),
            ),

          actions: [
            InkWell(
              onTap: () => _showEventPicker(context),

              child: Container(
                  margin: EdgeInsets.only(right: 12),
                  width: 80,

                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Color.fromRGBO(50, 50, 50, 1.0),
                  ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      indexFromEvent[event] as String,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              )
            )
          ],
        ),

        bottomNavigationBar: Container(
          width: 100,
          height: 70,
          margin: EdgeInsets.fromLTRB(12, 5, 12, 25),

          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: Color.fromRGBO(50, 50, 50, 1.0),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.grid_view), iconSize: 30, color: Colors.white, splashColor: Colors.transparent, highlightColor: Colors.transparent)
              ),
              Container(
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.format_list_bulleted_outlined), iconSize: 30, color: Colors.grey, splashColor: Colors.transparent, highlightColor: Colors.transparent)
              ),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined), iconSize: 30, color: Colors.grey, splashColor: Colors.transparent, highlightColor: Colors.transparent)
              )
            ],
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 80),

                  child: Text(
                    scramble,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),

            getInputWidgetType()
          ]
        )
      ),
    );
  }

  Widget touchInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (duration.inMilliseconds * 0.001).toStringAsFixed(2),
          //time.toStringAsFixed(2),
          style: TextStyle(
            color: timerColor,
            fontSize: 100.0,
          ),
        ),
      ],
    );
  }

  Widget typeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         SizedBox(
           width: 230,
           height: 100,

           child: TextField(
             style: TextStyle(
               color: Colors.white,
             ),

             keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),

             decoration: InputDecoration(

               hintStyle: TextStyle(
                 color: Colors.white,
               ),

               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.white, width: 0.0),
               ),
               labelText: 'Enter time',
             ),
           )
         )
      ],
    );
  }

  Widget smartCubeInput() {
    return Container(
      padding: EdgeInsets.all(10),

      child: Text(
        "No cube connected",
        textAlign: TextAlign.center,

        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      )
    );
  }

  Widget getInputWidgetType() {
    if (enterTimeMode == 0) {
      return touchInput();
    }

    if (enterTimeMode == 1) {
      return typeInput();
    }

    return smartCubeInput();
  }

  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }


  void _showInputPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          width: double.infinity,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: enterTimeMode),
            children: [
              Text('Touch'),
              Text('Type'),
              Text('Smart cube'),
            ],
            onSelectedItemChanged: (value) {
              setState(() {
                enterTimeMode = value;

                if (enterTimeMode == 0) {
                  enterTimeIcon = Icons.touch_app_rounded;
                } else if (enterTimeMode == 1) {
                  enterTimeIcon = Icons.keyboard_alt;
                } else {
                  enterTimeIcon = Icons.bluetooth;
                }
              });
            },
          ),
        ));
  }

  void _showEventPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) =>
            Container(
              width: double.infinity,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: event),
                children: [
                  Text('2x2'),
                  Text('3x3'),
                  Text('4x4'),
                  Text('5x5'),
                  Text('6x6'),
                  Text('7x7'),
                  Text('Pyraminx'),
                  Text('Skewb'),
                  Text('Square-1'),
                  Text('Clock'),
                  Text('Megaminx'),
                ],
                onSelectedItemChanged: (value) {
                  event = value;
                  setState(() {});
                },
              ),
            ));
  }
}

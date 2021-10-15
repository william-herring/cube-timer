import 'package:cube_timer/screens/timer.dart';
import 'package:flutter/material.dart';

class TimeListScreen extends StatefulWidget {
  const TimeListScreen({Key? key}) : super(key: key);

  @override
  _TimeListScreenState createState() => _TimeListScreenState();
}

class _TimeListScreenState extends State<TimeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: IconButton(onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => TimerScreen(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                }, icon: Icon(Icons.timer), iconSize: 30, color: Colors.grey, splashColor: Colors.transparent, highlightColor: Colors.transparent)
            ),
            Container(
                child: IconButton(onPressed: () {}, icon: Icon(Icons.format_list_bulleted_outlined), iconSize: 30, color: Colors.white, splashColor: Colors.transparent, highlightColor: Colors.transparent)
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined), iconSize: 30, color: Colors.grey, splashColor: Colors.transparent, highlightColor: Colors.transparent)
            )
          ],
        ),
      ),
    );
  }
}

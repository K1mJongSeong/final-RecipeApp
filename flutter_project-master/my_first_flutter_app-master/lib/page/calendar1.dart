import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter_app/todoList.dart';

TextStyle dayStyle(FontWeight fontWeight) {
  return TextStyle(color: Color(0xff30384c), fontWeight: fontWeight);
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  Container taskList(
      String title, String description, IconData iconImg, Color iconColor) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Icon(
            iconImg,
            color: iconColor,
            size: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text(description,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.normal))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            TableCalendar(
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                weekdayStyle: dayStyle(FontWeight.normal),
                weekendStyle: dayStyle(FontWeight.normal),
                selectedColor: Colors.lightGreen,
                todayColor: Colors.lightGreen,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      color: Color(0xff30384c),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  weekdayStyle: TextStyle(
                      color: Color(0xff30384c),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  dowTextBuilder: (date, locale) {
                    return DateFormat.E(locale).format(date).substring(0, 1);
                  }),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Color(0xff30384c),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Color(0xff30384c),
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Color(0xff30384c),
                  )),
              calendarController: _controller,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((50)),
                      topRight: Radius.circular(50)),
                  color: Color(0xff30384c)),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      taskList(
                          "대파",
                          "2,980원",
                          CupertinoIcons.check_mark_circled_solid,
                          Color(0xff00cf8d)),
                      taskList(
                          "양파",
                          "2,500원",
                          CupertinoIcons.check_mark_circled_solid,
                          Color(0xff00cf8d)),
                      taskList(
                          "다진마늘",
                          "3,000원",
                          CupertinoIcons.check_mark_circled_solid,
                          Color(0xff00cf8d)),
                      taskList(
                          "팽이버섯",
                          "2,700원",
                          CupertinoIcons.check_mark_circled_solid,
                          Color(0xff00cf8d)),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                            Color(0xff30384c).withOpacity(0),
                            Color(0xff30384c)
                          ],
                              stops: [
                            0.0,
                            1.0
                          ])),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 20,
                    child: Column(
                      children: [
                        ButtonTheme(
                            child: RaisedButton(
                          color: Color(0xff30384c),
                          elevation: 0.0,
                          child: Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.white,
                            size: 55.0,
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TodoListPage())),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

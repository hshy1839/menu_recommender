// lib/main_calendar.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatefulWidget {
  @override
  _MainCalendarState createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isSameDay(DateTime? day1, DateTime day2) {
    if (day1 == null) return false;
    return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay, // 현재 날짜를 기준으로 달력을 표시
      firstDay: DateTime(2020), // 달력의 시작 날짜 설정
      lastDay: DateTime(2030),  // 달력의 마지막 날짜 설정
      selectedDayPredicate: (day) => _isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        print('Selected day: $selectedDay');
      },
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}

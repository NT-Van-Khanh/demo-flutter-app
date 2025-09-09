import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    
    final initalDate = DateTime.now();
    final firstDate = DateTime(2000,9,05);
    final lastDate = DateTime(2100,9,05);
    DateTime? chooseDate = initalDate;
    void setChooseDate(date){
      setState(() {
        chooseDate = date;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text( AppLocalizations.of(context)!.calendar),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              child: CalendarDatePicker(
                  initialDate: initalDate, 
                  firstDate: firstDate, 
                  lastDate: lastDate, 
                  onDateChanged: (date)=>{setChooseDate(date)}),
            ),
          ),
          Text(chooseDate == null? "Ngày chưa được chọn": chooseDate.toString()),
        ],
      ),

    );
  }
}
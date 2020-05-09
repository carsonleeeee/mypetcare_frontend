import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'models/userList.dart';
import 'setting.dart';
import 'userprofile.dart';
import 'models/bookingList.dart';
import 'booking.dart';

class HomePage extends StatefulWidget {  
  final UserList userList;
  final List<BookingList> bookingList;

  HomePage(this.userList,this.bookingList);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  
  @override
  void initState(){
    super.initState();
    _controller = CalendarController();
  }

  Widget build(BuildContext context) {
   return Scaffold( 
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Text('Home Page',style: TextStyle(color: Colors.black),),
         actions: <Widget>[
            // action button
            IconButton(
              color: Colors.blue,
              icon: Icon(Icons.settings),
              onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting(widget.userList))
                 );
              },
            ),
            // action button
            IconButton(
              color: Colors.blue,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile(widget.userList))
                  );
              },
            ),],
      ),         
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 50.0),
          Container(       
            padding: EdgeInsets.symmetric(horizontal: 70.0),                                  
            child: Image.asset('assets/images/petcareIcon.jpeg') 
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingScreen(widget.bookingList, widget.userList))
                  )
                },                
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.calendar_today,color: Colors.blue),
                    Text("Appointment")
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width - 80.0,            
            child: TableCalendar(calendarController: _controller,)
          )          
        ],),
      ),            
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        backgroundColor: Colors.blue,
        label: Text('Emergency Call'),
        icon: Icon(Icons.call),        
      )
      );   
  }
}
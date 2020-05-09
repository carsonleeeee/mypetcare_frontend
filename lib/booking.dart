import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/userprofile.dart';
import 'models/bookingList.dart';
import 'appointmentDetail.dart';
import 'models/MockUser.dart';
import 'models/userList.dart';

class BookingScreen extends StatefulWidget {
  final List<BookingList> bookingList;
  final UserList userList;

  BookingScreen(this.bookingList,this.userList);
  @override
  _BookingPageScreenState createState() => _BookingPageScreenState();
}

class _BookingPageScreenState extends State<BookingScreen> {
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(   
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Row(children: <Widget>[          
          Text('Booking',style: TextStyle(color: Colors.black),),
          SizedBox(width: 140.0),
          IconButton(
              icon: Icon(Icons.people, color: Colors.black),
               onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile(widget.userList))
                  );
                },
            ),
        ],)
      ),       
      body: Column(children: <Widget>[
          SizedBox(height: 50.0),
          Container(       
            padding: EdgeInsets.symmetric(horizontal: 70.0),                                  
            child: Image.asset('assets/images/petcareIcon.jpeg') 
          ),
          SizedBox(height: 20.0),
          Container(
            width: 300.0,
            height: 40.0,
            child: TextField(               
              maxLines: 1,
              style: TextStyle(height: 2.8),
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Type in your text",
                fillColor: Colors.white70
              ),
            ),            
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width -40.0,
              child: ListView.separated(
                itemCount: widget.bookingList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(widget.bookingList[index].name),
                  subtitle: Text(widget.bookingList[index].rate.toString()+" rating\n"+widget.bookingList[index].address),              
                  onTap: () {                    
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentDetail(index))
                    );          
                  },
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
              ),     
            ),
          ),                    
        ],)
   );
  }
}
import 'package:flutter/material.dart';
import 'models/appointmentField.dart';
import 'models/bookingList.dart';
import 'models/MockBooking.dart';
import 'models/appointmentField.dart';

alertDialog(BuildContext context,type,msg) {
  // This is the ok button
  Widget ok = FlatButton(
    child: Text("Okay"),
    onPressed: () {Navigator.of(context, rootNavigator: true).pop('dialog');},
  ); 
  // show the alert dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text(type),
    content: Text(msg),
    actions: [
      ok,
    ],
    elevation: 5,
    
  );
    },
  );
}

class AppointmentDetail extends StatefulWidget {
  final int index;

  AppointmentDetail(this.index);
  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  String name,email,phone,reason = "Flu",date,time;   
  bool booked = false;                 

  @override
  void dispose() {          
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    final BookingList bookingList = mockBookingList[widget.index];  
    BookingDetail bookingDetail = bookingList.bookingDetail;                 
        
    if(bookingDetail.name?.isEmpty ?? true){
      booked = false;
    }
    else{
      booked = true;
    }

    DropdownButton reasonField(value){      
      return DropdownButton<String>(
          value: value != null ? value : reason,          
          iconSize: 24,
          elevation: 16,                    
          onChanged: (String newValue) {
            setState(() {
              reason = newValue;
            });
          },
          items: <String>['Flu', 'Injury', 'Fever']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
    }

    RaisedButton showButton(booked){
      if(bookingDetail.name?.isEmpty ?? true){
        booked = false;
      }
      else{
        booked = true;
      }

      if(booked == false){
        return RaisedButton(                    
            child: Text("Add Appointment", textAlign: TextAlign.center),                  
            onPressed: () {
              setState(() {
                mockBookingList[widget.index].bookingDetail = BookingDetail(nameController.text,emailController.text,phoneController.text,reason,dateController.text,timeController.text);                                                        
              });                                 
              nameController.text = "";
              emailController.text = "";
              phoneController.text = "";
              dateController.text = "";
              timeController.text = "";
    
              Navigator.pop(context, widget.index);                                                     
            },
        );
      }  
      else{
        return RaisedButton(                    
            child: Text("Cancel Appointment", textAlign: TextAlign.center),                  
            onPressed: () {
              setState(() {
                mockBookingList[widget.index].bookingDetail = BookingDetail(null,null,null,null,null,null);                
              });              

              Navigator.pop(context, widget.index);                                                     
            },
        );
      }
    }
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Text('Appointment',style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
          SizedBox(height: 50.0),
          Container(       
            padding: EdgeInsets.symmetric(horizontal: 70.0),                                  
            child: Image.asset('assets/images/petcareIcon.jpeg') 
          ),
          SizedBox(height: 20.0),
          Container(            
            width: MediaQuery.of(context).size.width - 70.0,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
            ),
            child: Column(children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(bookingList.name,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),              
              ),              
              Align(
                alignment: Alignment.topLeft,
                child: Text(bookingList.rate.toString()+" rating\n"+bookingList.address)
              ),
            ],)
          ),
          Container(
            width: MediaQuery.of(context).size.width - 70.0,
            alignment: Alignment.centerLeft,
            child: Column(
              
              children: <Widget>[
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("APPOINTMENT DETAILS: ")
              ),              
              SizedBox(height: 30.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("NAME: "),
                    booked == true ? Text(bookingDetail.name) : nameField
                  ],
                )
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("EMAIL: "),
                    booked == true ? Text(bookingDetail.email) : emailField
                  ],
                )
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("PHONE NO: "),
                    booked == true ? Text(bookingDetail.phone) : phoneField
                  ],
                )
              ),              
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("REASON FOR VISIT: "),
                    booked == true ? reasonField(bookingDetail.reason) : reasonField(null)
                  ],
                )
              ),              
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("DATE: "),
                    booked == true ? Text(bookingDetail.date) : dateField
                  ],
                )
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text("TIME: "),
                    booked == true ? Text(bookingDetail.time) : timeField
                  ],
                )
              ),      
              SizedBox(height: 30.0),
              Align(
                alignment: Alignment.center,
                child: showButton(booked)
              ),             
              SizedBox(height: 300.0)
            ],)
          ),          
        ],)
        )
      );
  }
}

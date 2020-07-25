import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/models/appointmentField.dart';
import 'package:mypetcare_userprofile/models/bookingList.dart';
import 'package:mypetcare_userprofile/models/userList.dart';
import 'package:mypetcare_userprofile/services/booking_service.dart';

alertDialog(BuildContext context, type, msg) {
  // This is the ok button
  Widget ok = FlatButton(
    child: Text("Okay"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
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
  final ClinicList clinic;
  final User user;

  AppointmentDetail(this.user, this.clinic);
  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  String reason = "Flu";
  bool booked = false;
  final bookingDataService = BookingDataService();

  @override
  Widget build(BuildContext context) {
    List<BookingList> bookingList = widget.clinic.bookingList;
    BookingList booking;
    int bookingIndex = 0;
    phoneController.text = "";
    timeController.text = "";
    dateController.text = "";

    for (int i = 0; i < bookingList.length; i++) {
      if (bookingList[i].id == widget.user.id) {
        booking = bookingList[i];
        bookingIndex = i;
        booked = true;
        break;
      }
    }

    void _updateBooking(String id) async {
      final result = await bookingDataService.updateBooking(
          clinicId: id, bookingList: bookingList);

      if (result != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                AppointmentDetail(widget.user, widget.clinic)));
      }
    }

    void _addAppointment(String id, BookingList booking) {
      setState(() {
        bookingList.add(booking);
        booked = true;
      });

      _updateBooking(id);
    }

    void _cancelAppointment(String id) {
      setState(() {
        bookingList.removeAt(bookingIndex);
        booked = false;
      });

      _updateBooking(id);
    }

    DropdownButton reasonField(value) {
      return DropdownButton<String>(
        value: value != null ? value : reason,
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black),
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

    RaisedButton showButton(booked) {
      if (booked == false) {
        return RaisedButton(
          child: Text("Add Appointment", textAlign: TextAlign.center),
          onPressed: () {
            if (dateController.text.length > 0 &&
                timeController.text.length > 0) {
              if (widget.user.profile.phone != null ||
                  phoneController.text.length > 0) {
                _addAppointment(
                    widget.clinic.id,
                    new BookingList(widget.user.id, reason, dateController.text,
                        timeController.text));
              } else {
                alertDialog(
                    context, 'Information', 'Please enter phone no field!');
              }
            } else {
              if (dateController.text.length == 0 &&
                  timeController.text.length == 0) {
                alertDialog(context, 'Information',
                    'Please enter date field and time field!');
              } else if (dateController.text.length == 0) {
                alertDialog(context, 'Information', 'Please enter date field!');
              } else if (timeController.text.length == 0) {
                alertDialog(context, 'Information', 'Please enter time field!');
              }
            }
          },
        );
      } else {
        return RaisedButton(
          child: Text("Cancel Appointment", textAlign: TextAlign.center),
          onPressed: () {
            _cancelAppointment(widget.clinic.id);
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
          title: Text(
            'Appointment',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 70.0),
                child: Image.asset('assets/images/petcareIcon.jpeg')),
            SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width - 70.0,
                padding: const EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.clinic.name,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.clinic.rate.toString() +
                            " rating\n" +
                            widget.clinic.address)),
                  ],
                )),
            Container(
                width: MediaQuery.of(context).size.width - 70.0,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Appointment Details: ",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold))),
                    SizedBox(height: 30.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Text("Name: "),
                            Text(widget.user.username,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    SizedBox(height: 20.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Text("Email: "),
                            Text(widget.user.email,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    SizedBox(height: 20.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Text("Phone No: "),
                            widget.user.profile.phone == null
                                ? phoneField
                                : Text(widget.user.profile.phone,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))
                          ],
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Text("Reason For Visit: "),
                            booked == true
                                ? reasonField(booking.reason)
                                : reasonField(null)
                          ],
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Text("Date: "),
                            booked == true
                                ? Text(booking.date,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))
                                : dateField
                          ],
                        )),
                    SizedBox(height: 10.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Text("Time: "),
                            booked == true
                                ? Text(booking.time,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold))
                                : timeField
                          ],
                        )),
                    SizedBox(height: 30.0),
                    Align(
                        alignment: Alignment.center, child: showButton(booked)),
                    SizedBox(height: 300.0)
                  ],
                )),
          ],
        )));
  }
}

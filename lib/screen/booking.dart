import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/services/booking_service.dart';
import 'package:mypetcare_userprofile/screen/userprofile.dart';
import 'package:mypetcare_userprofile/models/bookingList.dart';
import 'package:mypetcare_userprofile/screen/appointmentDetail.dart';
import 'package:mypetcare_userprofile/models/userList.dart';

class BookingScreen extends StatefulWidget {
  final User user;

  BookingScreen(this.user);

  @override
  _BookingPageScreenState createState() => _BookingPageScreenState();
}

class _BookingPageScreenState extends State<BookingScreen> {
  List<ClinicList> clinicList, showedClinicList;
  Future<List<ClinicList>> _futureClinic;
  final bookingDataService = BookingDataService();

  @override
  void initState() {
    super.initState();
    _futureClinic = bookingDataService.getClinicList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _futureClinic,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            clinicList = snapshot.data;
            showedClinicList == null
                ? showedClinicList = List.from(clinicList)
                : showedClinicList.length > 0
                    ? showedClinicList = showedClinicList
                    : showedClinicList = List.from(clinicList);

            return buildBookingScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Clinic data is being fetching'),
          ],
        ),
      ),
    );
  }

  Scaffold buildBookingScreen() {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey.shade100,
            title: Row(
              children: <Widget>[
                Text(
                  'Booking',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 140.0),
                IconButton(
                  icon: Icon(Icons.people, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfile(widget.user)));
                  },
                ),
              ],
            )),
        body: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 70.0),
                child: Image.asset('assets/images/petcareIcon.jpeg')),
            SizedBox(height: 20.0),
            Container(
              width: 300.0,
              height: 50.0,
              child: TextField(
                  maxLines: 1,
                  style: TextStyle(height: 1.8),
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your text",
                      fillColor: Colors.white70),
                  onChanged: (text) {
                    setState(() {
                      if (text.length > 0) {
                        showedClinicList.clear();

                        for (int i = 0; i < clinicList.length; i++) {
                          if (clinicList[i].name.contains(
                              new RegExp(text, caseSensitive: false))) {
                            showedClinicList.add(clinicList[i]);
                          }
                        }
                      } else {
                        showedClinicList = List.from(clinicList);
                      }
                    });
                  }),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 40.0,
                child: ListView.separated(
                  itemCount: showedClinicList.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(showedClinicList.elementAt(index).name),
                    subtitle: Text(
                        showedClinicList.elementAt(index).rate.toString() +
                            " rating\n" +
                            showedClinicList.elementAt(index).address),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentDetail(
                                  widget.user, clinicList.elementAt(index))));
                    },
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

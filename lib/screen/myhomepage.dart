import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mypetcare_userprofile/services/local_notications_helper.dart';
import 'package:mypetcare_userprofile/screen/signup.dart';
import 'package:mypetcare_userprofile/screen/HomePage.dart';
import 'package:mypetcare_userprofile/page/second_page.dart';
import 'package:mypetcare_userprofile/models/userList.dart';
import 'package:mypetcare_userprofile/services/user_service.dart';

alertDialog(BuildContext context, type, msg) {
  Widget ok = FlatButton(
    child: Text("Okay"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );

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

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool remember = true;
  bool verified = false;
  int userListIndex = 0;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  List<User> userList;  
  Future<List<User>> _futureUser;  
  final userDataService = UserDataService();  
  int newUserIndex, maxUserIndex = 0;

  final notifications = FlutterLocalNotificationsPlugin();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(initializationSettingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
    
    _futureUser = userDataService.getUserList();
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {            
            userList = snapshot.data;                        

            return buildMyHomePageScreen();
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
            Text('Appointment data is being fetching'),
          ],
        ),
      ),
    );
  }

  Scaffold buildMyHomePageScreen() {
    final emailField = TextField(
      controller: userNameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border: OutlineInputBorder()),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder()),
    );
    final loginButon = RaisedButton(
      color: Color(0xff01A0C7),
      child: Text("Sign In",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      onPressed: () {
        for (int i = 0; i < userList.length; i++) {
          String name = userNameController.text.replaceAll(' ', '');
          String pwd = passwordController.text.replaceAll(' ', '');
          if (name == userList[i].username &&
              pwd == userList[i].password) {
            verified = true;
            userListIndex = i;
            break;
          }
        }

        if (verified == true) {
          alertDialog(context, 'Information', 'Login successfully!');
          showOngoingNotification(notifications,
              title: 'PetCare', body: 'Login Successfully!');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(userList.elementAt(userListIndex))));
        } else {
          alertDialog(context, 'Information', 'Login failure!');
        }
      },
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 45.0),
                Text('LOGIN',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 65.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                Stack(children: <Widget>[
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      value: remember,
                      onChanged: (bool value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                  ),
                  Container(
                      child: Column(children: <Widget>[
                    SizedBox(height: 3.5),
                    Text('          Remember Me')
                  ])),
                  Container(
                      height: 80.0,
                      child: Row(children: [
                        SizedBox(width: 4.0),
                        Text('Forgot Password',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold))
                      ])),
                  Container(
                    alignment: Alignment.centerRight,
                    child:
                        SizedBox(width: 130.0, height: 60.0, child: loginButon),
                  ),
                ]),
                Container(
                    alignment: Alignment.bottomRight,
                    child: Column(children: <Widget>[
                      SizedBox(height: 150.0),
                      Row(children: [
                        Text('New Member? Click here to ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.bold)),
                        InkWell(
                          child: Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                          onTap: () {                          
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                        )
                      ])
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

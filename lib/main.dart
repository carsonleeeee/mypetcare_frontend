import 'package:flutter/material.dart';
import 'dart:async';
import 'booking.dart';
import 'models/MockBooking.dart';
import 'models/MockProfile.dart';
import 'models/bookingList.dart';
import 'models/MockUser.dart';
import 'models/userList.dart';
import 'signup.dart';
import 'HomePage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'local_notications_helper.dart';
import 'page/second_page.dart';
import 'package:animated_splash/animated_splash.dart';

void main() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: MyApp(), 2: MyApp()};
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplash(
      imagePath: 'assets/images/petcare.jpeg',
      home: MyApp(),
      customFunction: duringSplash,
      duration: 2500,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    ),
  ));
} 

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LOGIN',userList: mockUserList,),
      debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.userList}) : super(key: key); 
  final String title;
  final List<UserList> userList;  
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  
  bool remember = true;
  bool verified = false;
  int userListIndex = 0;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

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
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
  ); 

  @override
  Widget build(BuildContext contextNew) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final emailField = TextField(
      controller: userNameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder()),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder()),
    );
    final loginButon = RaisedButton(        
        color: Color(0xff01A0C7),
        child: Text("Sign In", textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () {             
          for(int i=0;i<widget.userList.length;i++){
            String name = userNameController.text.replaceAll(' ', '');
            String pwd = passwordController.text.replaceAll(' ', '');
            if(name == widget.userList[i].username && pwd == widget.userList[i].password){              
              verified = true;
              userListIndex = i;
              break;
            }
          }

          if(verified == true){
            alertDialog(context,'Information','Login successfully!');
            showOngoingNotification(notifications,
                    title: 'PetCare', body: 'Login Successfully!');
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(mockUserList[userListIndex],mockBookingList))
            );          
          }
          else{
            alertDialog(context,'Information','Login failure!');
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 65.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),                      
                Stack(                      
                  children: <Widget>[                                            
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
                    child: Column(
                      children: <Widget>[
                        SizedBox(height:3.5),
                        Text('          Remember Me')
                      ])
                  ),                         
                  Container(                            
                    height: 80.0,                                                                                      
                    child: Row(
                              //ROW 2
                              children: [  
                                SizedBox(width: 4.0),
                                Text('Forgot Password',                                        
                                style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold))
                          ])
                  ),  
                  Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(                                                                   
                    width: 130.0,
                    height: 60.0,
                    child: loginButon 
                  ),   
                  ),                                     
                ]),   
                Container(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    children: <Widget>[   
                      SizedBox(height: 150.0),                          
                      Row(
                        children: [                          
                          Text('New Member? Click here to ',                                        
                                style: TextStyle(fontSize: 18,color: Colors.indigo[900], fontWeight: FontWeight.bold)),                          
                          InkWell(
                              child: Text('Sign Up',style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold))  ,
                              onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp())
                                ); 
                              },
                          )
                        ])
                  ])
                )                          
              ],
            ),
          ),
        ),
      ),
    );    
  }
}

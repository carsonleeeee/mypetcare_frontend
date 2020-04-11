import 'package:flutter/material.dart';
import 'dart:async';

void main() {   
  runApp(MyApp());
} 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
            child: Text('My Cool App',
                style: TextStyle(color: Colors.black, fontSize: 20.0))));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetCare',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LOGIN'),
      debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool remember = true;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);  

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext contextNew) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder()),
    );
    final passwordField = TextField(
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
        },
    );
                     
    return Scaffold(
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
                      SizedBox(height: 200.0),                          
                      Row(
                        children: [                          
                          Text('New Member? Click here to ',                                        
                                style: TextStyle(fontSize: 18,color: Colors.indigo[900], fontWeight: FontWeight.bold)),
                          Text('Sign Up',                                        
                                style: TextStyle(fontSize: 18,color: Colors.blue, fontWeight: FontWeight.bold))  
                        ])
                  ])
                ),                  
              ],
            ),
          ),
        ),
      ),
    );    
  }
}

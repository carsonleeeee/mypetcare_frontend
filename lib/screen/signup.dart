import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:mypetcare_userprofile/models/profileList.dart';
import 'package:mypetcare_userprofile/models/userList.dart';
import 'package:mypetcare_userprofile/screen/myhomepage.dart';
import 'package:mypetcare_userprofile/services/user_service.dart';

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

class SignUp extends StatefulWidget {
  
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File imageFile;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwdController = TextEditingController();
  int userCount = 1;
  final userDataService = UserDataService();

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _addUser(User user) async {
    final result = await userDataService.createUser(user: user);

    if (result != null) {
      await new Future.delayed(const Duration(seconds: 1));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }    
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Choose"),
              content: SingleChildScrollView(
                  child: ListBody(children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ])));
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No Image Selected");
    } else {
      return Image.file(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: Column(children: <Widget>[
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.face,
                                color: Colors.black,
                              ),
                            ),
                            ListTile(
                                title: _decideImageView(),
                                leading: RaisedButton(
                                    onPressed: () {
                                      _showChoiceDialog(context);
                                    },
                                    child: Icon(Icons.add_circle,
                                        color: Colors.black))),
                          ]),
                    ),
                    TextField(
                        autofocus: false,
                        controller: userNameController,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)))),
                    SizedBox(height: 20.0),
                    TextField(
                        autofocus: false,
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)))),
                    SizedBox(height: 20.0),
                    TextField(
                      autofocus: false,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal))),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      autofocus: false,
                      controller: confirmPwdController,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal))),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        height: 40.0,
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.blueAccent,
                            color: Colors.blue,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async {
                                userCount++;
                                ProfileList profile$userCount =
                                    ProfileList("empty", "empty", "empty"); 
                                User user$userCount = new User(
                                    "1",
                                    userNameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    profile$userCount);
                                _addUser(user$userCount);
                                alertDialog(context, 'Information',
                                    'Sign Up successfully! Please update your profile.');
                              },
                              child: Center(
                                  child: Text('Confirm',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Source Sans Pro',
                                      ))),
                            ))),
                    SizedBox(height: 500.0)
                  ]))
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/models/profileList.dart';
import 'package:mypetcare_userprofile/widgets/info_card.dart';
import 'setting.dart';
import 'models/appointmentField.dart';
import 'models/userList.dart';

const phone = '+60 12-3456789';
const email = 'sampleuser@gmail.com';
const pet = 'Cat';
const petname = 'Shino';


class UserProfile extends StatefulWidget {
  final UserList userList;
  bool editMode = false;

  UserProfile(this.userList,{this.editMode});

  @override
  _UserProfile createState() => _UserProfile();
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

class _UserProfile extends State<UserProfile> { 
  bool edit = false;
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  
  @override
  Widget build(BuildContext context) {    
    Column isEditMode(){
      if(widget.userList.profileList.email == null || widget.editMode == true){
        edit = true;
      }
      else{
        edit = false;
      }

      if(edit == false){
        return Column(children: <Widget>[
              InfoCard(
                text: widget.userList.profileList.phone,
                icon: Icons.phone,                
              ),
              InfoCard(
                text: widget.userList.profileList.email,
                icon: Icons.email,                
              ),
              InfoCard(
                text: widget.userList.profileList.pet,
                icon: Icons.pets,                
              ),
              InfoCard(
                text: widget.userList.profileList.petname,
                icon: Icons.pets,                
              )
            ]);
      }
      else{
        return Column(children: <Widget>[
          userPhoneField,
          SizedBox(height: 20.0),
          userEmailField,
          SizedBox(height: 20.0),
          userPetField,
          SizedBox(height: 20.0),
          userPetNameField,
          SizedBox(height: 10.0),
          RaisedButton(                    
              child: Text("Save", textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),                  
              onPressed: () {                                                                  
                widget.userList.profileList = ProfileList(userPhoneController.text, userEmailController.text, userPetController.text, userPetNameController.text);
                alertDialog(context,'Information','Profile saved successfully!');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting(widget.userList))
                );
              },
              color: Colors.teal
          ),
          SizedBox(height: 300.0)                  
        ]);
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        elevation: 0,        
        title: Container(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.menu, color: Colors.teal[100]),
               onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting(widget.userList))
                  );
                },
            ),
        ),
      ),
      backgroundColor: Colors.teal[100],
      body: SingleChildScrollView(                                  
        child: Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[            
                  SizedBox(height: 50.0),
                  CircleAvatar(
                    radius: 50 ,
                    backgroundImage: AssetImage("assets/images/profile.jpg"), 
                  ),
                  Text(
                    widget.userList.username,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(color: Colors.teal.shade700,),
                  ),
                  isEditMode(),
                  SizedBox(height: 20.0),                                           
                ]),
            ),
        ),
      );
  }
}

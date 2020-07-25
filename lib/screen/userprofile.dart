import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/models/profileList.dart';
import 'package:mypetcare_userprofile/services/user_service.dart';
import 'package:mypetcare_userprofile/widgets/info_card.dart';
import 'package:mypetcare_userprofile/screen/setting.dart';
import 'package:mypetcare_userprofile/models/appointmentField.dart';
import 'package:mypetcare_userprofile/models/userList.dart';

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

class UserProfile extends StatefulWidget {
  final User user;
  bool editMode = false;

  UserProfile(this.user,{this.editMode});

  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> { 
  bool edit = false;
  final TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final userDataService = new UserDataService();
  
  void _updateProfile(String id, ProfileList profile) async {
      final result = await userDataService.updateProfileList(
          id: id, profile: profile);

      if (result != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                UserProfile(widget.user)));
      }
    }

  @override
  Widget build(BuildContext context) {    
    Column isEditMode(){
      if(widget.user.email == null || widget.editMode == true){
        edit = true;
      }
      else{
        edit = false;
      }

      if(edit == false){
        return Column(children: <Widget>[
              InfoCard(
                text: widget.user.profile.phone == null ? "" : widget.user.profile.phone,
                icon: Icons.phone,                
              ),
              InfoCard(
                text: widget.user.email == null ? "" : widget.user.email,
                icon: Icons.email,                
              ),
              InfoCard(
                text: widget.user.profile.pet == null ? "" : widget.user.profile.pet,
                icon: Icons.pets,                
              ),
              InfoCard(
                text: widget.user.profile.petname == null ? "" : widget.user.profile.petname,
                icon: Icons.pets,                
              )
            ]);
      }
      else{
        return Column(children: <Widget>[
          userPhoneField,
          SizedBox(height: 10.0),         
          userPetField,
          SizedBox(height: 10.0),
          userPetNameField,
          SizedBox(height: 10.0),
          RaisedButton(                    
              child: Text("Save", textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),                  
              onPressed: () {                                                                  
                widget.user.profile = ProfileList(userPhoneController.text, userPetController.text, userPetNameController.text);
                _updateProfile(widget.user.id, widget.user.profile);
                alertDialog(context,'Information','Profile saved successfully!');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting(widget.user))
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
                    MaterialPageRoute(builder: (context) => Setting(widget.user))
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
                    widget.user.username,
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

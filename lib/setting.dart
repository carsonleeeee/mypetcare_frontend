import "dart:async";
import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/main.dart';
import 'userprofile.dart';
import 'models/userList.dart';

void main() => runApp(MyApp());

class Setting extends StatefulWidget {
  final UserList userList;

  Setting(this.userList);

  @override
  _SettingPage createState() => _SettingPage();
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

class _SettingPage extends State<Setting> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey.shade100,
        title: Text('Setting',style: TextStyle(color: Colors.black),),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.teal[100],
                  child: ListTile(
                    onTap: (){
                      //open user profile
                    },
                    title: Text(widget.userList.username,style: TextStyle(color: Colors.white, fontWeight: 
                    FontWeight.w500),),
                    leading: CircleAvatar(
                       radius: 10.0,
                       backgroundImage: AssetImage("assets/images/profile.jpg"),
                       ),
                       trailing: Icon(Icons.edit),
                        onLongPress: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserProfile(widget.userList,editMode: true))
                          );
                        },
                  ),
                ),
                const SizedBox(height: 10.0), 
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.lock_outline, color: Colors.black,),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (){
                            //open change password
                          },
                        ),
                        buildDivider(),
                        ListTile(
                        leading: Icon(Icons.language, color: Colors.black,),
                        title: Text("Change Language"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (){
                            //open change language
                          },
                        ),
                        buildDivider(),
                         ListTile(
                        leading: Icon(Icons.color_lens, color: Colors.black,),
                        title: Text("Change Color"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: (){
                            //open change language
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text("Notification Settings", style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),),
                SwitchListTile(
                  activeColor: Colors.teal[100],
                  contentPadding: const EdgeInsets.all(0),
                  value: true,
                  title: Text("Received Notification"),
                  onChanged: (val){},
                ),
                 SwitchListTile(
                  activeColor: Colors.teal[100],
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: Text("Received Newsletter"),
                  onChanged: null,
                ),
                 SwitchListTile(
                  activeColor: Colors.teal[100],
                  contentPadding: const EdgeInsets.all(0),
                  value: false,
                  title: Text("Received App Updates"),
                  onChanged: null,
                ),
              ],
            ),
          ),
           Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center, 
              decoration: BoxDecoration(
                color: Colors.teal[100],
                shape: BoxShape.circle,
              ),
             ),
        ),
         Positioned(
            bottom: 00,
            left: 00,
            child: IconButton(
              icon: Icon(Icons.power_settings_new, color: Colors.black),
              onPressed: () async {
                alertDialog(context,'Information','Logout succesfully!');
                await new Future.delayed(const Duration(seconds : 1));
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp())
                );                
              },
            ),
         ), 
        ],
      ),

   );
  }

  Container buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

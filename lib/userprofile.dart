import 'package:flutter/material.dart';
import 'package:mypetcare_userprofile/widgets/info_card.dart';
import 'setting.dart';

const phone = '+60 12-3456789';
const email = 'sampleuser@gmail.com';
const pet = 'Cat';
const petname = 'Shino';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      home: UserProfile(),
    );
  }
}


class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    MaterialPageRoute(builder: (context) => SettingPage())
                  );
                },
            ),
        ),
      ),      
      backgroundColor: Colors.teal[100],
      body: Container(              
        child: Column(
          children: <Widget>[
          SizedBox(
            height: 50.0
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            CircleAvatar(
              radius: 50 ,
             backgroundImage: AssetImage("assets/images/profile.jpg"), 
            ),
            Text(
              'Natalia John',
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
            InfoCard(
              text: phone,
              icon: Icons.phone,
              onPressed: () {print('phone');},
            ),
             InfoCard(
              text: email,
              icon: Icons.email,
              onPressed: () {print('email');},
            ),
             InfoCard(
              text: pet,
              icon: Icons.pets,
              onPressed: () {print('pet');},
             ),
             InfoCard(
              text: petname,
              icon: Icons.pets,
              onPressed: () {print('pet name');},
            ),
            
          ],
         
          ),
          ),                  
        ] 
        ),
        ),
      
      );
  }
}

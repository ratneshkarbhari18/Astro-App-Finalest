import 'package:flutter/material.dart';
import '../screens/Contact.dart';
import '../screens/About.dart';
import '../screens/TodaysHoroscope.dart';
import '../screens/Home.dart';
import '../screens/AskAnyQuestion.dart';
import '../screens/Login.dart';

class DrawerTemplateGeneral extends StatelessWidget {

 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
              },
              child: Container(
              color: Colors.blue,
              child: DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 35.0),
                    Icon(Icons.account_box,size: 50.0,color: Colors.white),
                    // Text("Login",style: TextStyle(color: Colors.white, fontSize: 20.0))
                  ],
                ),
              )
            ),
          ),
          ),
          ListTile(
            title: Text("Todays Horoscope"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> TodaysHoroscope()));
            },
          ),
          ListTile(
            title: Text("Ask Any Question"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> AskAnyQuestion()));
            },
          ),
          ListTile(
            title: Text("Home"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()));
            },
          ),
          ListTile(
            title: Text("About Us"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> About()));
            },
          ),
          ListTile(
            title: Text("Contact"),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Contact()));
            },
          ),
          
        ],
      ),
    );
  }
}

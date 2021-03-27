import 'package:flutter/material.dart';
import '../screens/Contact.dart';
import '../screens/About.dart';
import '../screens/TodaysHoroscope.dart';
import '../screens/Home.dart';
import '../screens/AskAnyQuestion.dart';

class DrawerTemplate extends StatelessWidget {

  final firstName;
  final lastName;
  final email;

  DrawerTemplate(this.firstName,this.lastName,this.email);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(firstName+" "+lastName),
            accountEmail: Text(email),
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

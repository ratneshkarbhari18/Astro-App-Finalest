import 'package:astro_app/templates/AppBarTemplate.dart';
import 'package:astro_app/templates/DrawerTemplate.dart';
import 'package:astro_app/templates/DrawerTemplateGeneral.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  var firstName;
  var lastName;
  var email;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _setUserState() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      firstName = prefs.getString("first_name");
      lastName = prefs.getString("last_name");
      email = prefs.getString("email");
    });
  }

  @override
  void initState() {
    super.initState();
    _setUserState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarTemplate("Contact"),
        drawer: (firstName==null)?DrawerTemplateGeneral():DrawerTemplate(firstName, lastName, email),
        body: ContactPage(),
      ),      
    );
  }
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

    
  
  @override
  Widget build(BuildContext context) { 
    return SafeArea(
        child: SingleChildScrollView( 
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(height: 10.0),
              Image.asset("assets/images/logo.jpg"),
              SizedBox(height: 20),
              Text("Address: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, preti"),
              SizedBox(height: 20),
              Text("Contact Number: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("+919137976398"),
              SizedBox(height: 20),
              Text("Email Address: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("ratneshkarbhari74@gmail.com"),
            ],
          ),
        ),      
      ),
    );
  }
}
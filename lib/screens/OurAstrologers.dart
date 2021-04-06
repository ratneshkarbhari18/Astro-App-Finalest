import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import '../templates/DrawerTemplateGeneral.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OurAstrologers extends StatefulWidget {
  @override
  _OurAstrologersState createState() => _OurAstrologersState();
}

class _OurAstrologersState extends State<OurAstrologers> {

  var firstName;
  var lastName;
  var email;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future setUserState() async{
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
    setUserState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          drawer: (firstName==null)?DrawerTemplateGeneral():DrawerTemplate(firstName,lastName,email),
        appBar: AppBarTemplate("Our Astrologers"),
        body: OurAstrologersPage(),
      ),
    );
  }
}

class OurAstrologersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Image.asset("assets/images/logo.jpg"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Text("FirstName LastName",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, preti",style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
          SizedBox(height: 16.0,),
          Image.asset("assets/images/logo.jpg"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Text("FirstName LastName",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, preti",style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
          Image.asset("assets/images/logo.jpg"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                Text("FirstName LastName",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, preti",style: TextStyle(fontSize: 16.0)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
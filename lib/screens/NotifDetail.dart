import 'package:astro_app/templates/DrawerTemplate.dart';
import 'package:astro_app/templates/DrawerTemplateGeneral.dart';
import 'package:flutter/material.dart';
import 'package:astro_app/templates/AppBarTemplate.dart';
import 'package:shared_preferences/shared_preferences.dart';





class NotifDetail extends StatefulWidget {
  var notification;
  NotifDetail(this.notification);
  @override
  _NotifDetailState createState() => _NotifDetailState(notification);
}

class _NotifDetailState extends State<NotifDetail> {

  var notification;
  _NotifDetailState(this.notification);

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
        appBar: AppBarTemplate("Details"),
        body: NotifDetailPage(notification),
      ),
    );
  }
}

class NotifDetailPage extends StatefulWidget {
  var notification;
  NotifDetailPage(this.notification);
  @override
  _NotifDetailPageState createState() => _NotifDetailPageState(this.notification);
}

class _NotifDetailPageState extends State<NotifDetailPage> {

  var notification;
  _NotifDetailPageState(this.notification);
  
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(notification["title"],style: TextStyle(fontSize: 30.0),),
            SizedBox(height: 10.0,),
            Text(notification["details"])
          ],
        ),
      ),
    );
  }
}
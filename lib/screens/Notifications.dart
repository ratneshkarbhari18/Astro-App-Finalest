import 'dart:convert';

import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import '../templates/DrawerTemplateGeneral.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/Constants.dart';
import '../screens/NotifDetail.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

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
        appBar: AppBarTemplate("Notifications"),
        body: NotificationsPage(),
      ),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  var allNotifs;

  Future fetchAllNotifs() async{
    var url = Constants.apiUrl+'fetch-notifications-api';
    var response = await http.post(Uri.parse(url), body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678'});
    if(response.statusCode==200){
      var resBody = jsonDecode(response.body);
      setState(() {
        allNotifs= jsonDecode(resBody["data"]);
      });
    }
    // print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    fetchAllNotifs();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: (allNotifs==null)? Center(child: CircularProgressIndicator()) :ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context,index){
            return Column(
              children: [
                ListTile(
                  
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotifDetail(allNotifs[index])));
                  },
                  title: Text(allNotifs[index]["title"]),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
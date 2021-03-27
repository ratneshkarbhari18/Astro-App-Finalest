import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/Login.dart';
import '../screens/Notifications.dart';



class AppBarTemplate extends StatelessWidget with PreferredSizeWidget {

  final title;
  AppBarTemplate(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBarContent(title);
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class AppBarContent extends StatefulWidget {
  final title;
  AppBarContent(this.title);
  @override
  _AppBarContentState createState() => _AppBarContentState(title);
}

class _AppBarContentState extends State<AppBarContent> {
  
  final title;
  _AppBarContentState(this.title);

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
    return AppBar(
      title: Text(this.title),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications), 
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Notifications()));
          }
        ),
        (firstName!=null)?IconButton(
          onPressed: () async{
            var prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
          },
          icon: Icon(Icons.logout),
        ):Text("")
      ],
    );
  }
}
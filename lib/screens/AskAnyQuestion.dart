import 'package:flutter/material.dart';
import '../templates/DrawerTemplateGeneral.dart';
import '../templates/DrawerTemplate.dart';
import '../templates/AppBarTemplate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AskAnyQuestion extends StatefulWidget {
  @override
  _AskAnyQuestionState createState() => _AskAnyQuestionState();
}

class _AskAnyQuestionState extends State<AskAnyQuestion> {

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
        appBar: AppBarTemplate("Ask Any Question"),
        body: AskAnyQuestionPage(),
      ),
    );
  }
}

class AskAnyQuestionPage extends StatefulWidget {
  @override
  _AskAnyQuestionPageState createState() => _AskAnyQuestionPageState();
}

class _AskAnyQuestionPageState extends State<AskAnyQuestionPage> {

  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();
  var contactNumberController = new TextEditingController();
  var messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: firstNameController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: lastNameController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: contactNumberController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              maxLines: 10,
              minLines: 5,
              controller: messageController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "Message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  )),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              height: 50.0,
              minWidth: double.maxFinite,
              onPressed: (){},
              color: Colors.blue,
              child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 16.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ],
        ),
      ),      
    );
  }
}
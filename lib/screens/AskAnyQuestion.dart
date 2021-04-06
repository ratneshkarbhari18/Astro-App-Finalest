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

  var _error = "";
  var _success = "";

  Future sendQuestion() async{
    var firstName = firstNameController.text;
    var lastName = lastNameController.text;
    var contactNumber = contactNumberController.text;
    var message = messageController.text;
    if(firstName==""||lastName==""||message==""||contactNumber==""){
      setState(() {
        _error = "Please Enter First Name, Last Name, Message and Contact Number";
      });
    }else{
      setState(() {
        _error = "";
      });

      var url = Constants.apiUrl+'send-question-api';
      var response = await http.post(Uri.parse(url), body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678', 'first_name': firstName, 'last_name': lastName ,"contact_number": contactNumber, "question": message});

      var responseBody = jsonDecode(response.body);
      if(response.statusCode==200){
        
        setState(() {
          _error = "";
        });

        if(responseBody["result"]=="failure"){
          setState(() {
            _error = responseBody["reason"];
          });
        }else{
          setState(() {
            _success = "We will connect with you shortly";
          });
        }


      }else{
          setState(() {
          _error = "Could not connect to server, please check your internet connection";
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
          children: [
            
            Image.asset("assets/images/logo.jpg"),
            Text(_error,style: TextStyle(fontSize: 20.0,color: Colors.red),),
            Text(_success,style: TextStyle(fontSize: 20.0,color: Colors.green),),
            SizedBox(
              height: 5.0,
            ),
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
              onPressed: sendQuestion,
              color: Colors.blue,
              child: Text("SEND QUESTION",style: TextStyle(color: Colors.white,fontSize: 16.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ],
        ),
      ),      
    );
  }
}
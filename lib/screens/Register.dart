import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/Constants.dart';
import 'dart:convert';
import './Login.dart';
import './Home.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplateGeneral.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  
  final firstNameController = new TextEditingController();
  final lastNameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final repeatPasswordController = new TextEditingController();

  var registerErrorText = "";

  Future registerExe () async{
    var enteredFirstName = firstNameController.text;
    var enteredLastName = lastNameController.text;
    var enteredEmail = emailController.text;
    var pw1 = passwordController.text;
    var pw2 = repeatPasswordController.text;
    if(pw1!=pw2){
      setState(() {
        registerErrorText = "Repeat Password does not match";
      });
    }else{
      var url = Constants.apiUrl+'subscriber-register-api';
      var response = await http.post(Uri.parse(url), body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678', 'email': enteredEmail, 'password': pw1, 'first_name': enteredFirstName, 'last_name': enteredLastName});
      if(response.statusCode==200){
        var responseBody = jsonDecode(response.body);
        if(responseBody["result"]=="failure"){
          setState(() {
            registerErrorText = responseBody["reason"];
          });
        }else{
          var prefs = await SharedPreferences.getInstance();
          prefs.setBool("logged_in", true);
          prefs.setString("first_name", enteredFirstName);
          prefs.setString("last_name", enteredLastName);
          prefs.setString("email", enteredEmail);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      }else{
        setState(() {
          registerErrorText = "Cannot connect to server, check your internet";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarTemplate("Register"),
        drawer: DrawerTemplateGeneral(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                children: [
                SizedBox(height: 30.0,),
                Image.asset("assets/images/logo.jpg"),
                SizedBox(height: 10.0,),
                Text(registerErrorText,style: TextStyle(color: Colors.red, fontSize: 16.0), textAlign: TextAlign.center,),
                SizedBox(height: 20.0,),
                TextField(
                  controller: firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Set a Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: repeatPasswordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Repeat Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  height: 50.0,
                  minWidth: double.maxFinite,
                  onPressed: registerExe,
                  color: Colors.blue,
                  child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 16.0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                SizedBox(height: 30.0,),
                Text("Already a Member?"),
                SizedBox(height: 10.0,),
                GestureDetector(
                  child: Text("Login Here", style: TextStyle(fontSize: 16.0, color: Colors.blue)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                  },
                ),
                SizedBox(height: 30.0,),              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
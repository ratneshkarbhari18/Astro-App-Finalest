import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import '../templates/DrawerTemplateGeneral.dart';
import 'package:http/http.dart' as http;
import '../utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Service extends StatefulWidget {
  final title;
  Service(this.title);
  @override
  _ServiceState createState() => _ServiceState(this.title);
}

class _ServiceState extends State<Service> {

  final title;
  _ServiceState(this.title);

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
        appBar: AppBarTemplate("Express Interest"),
        body: ServicePage(title),
      ),
    );
  }
}

class ServicePage extends StatefulWidget {

  final title;
  ServicePage(this.title);

  @override
  _ServicePageState createState() => _ServicePageState(title);
}


class _ServicePageState extends State<ServicePage> {

  final title;

  _ServicePageState(this.title);


  var nameController = new TextEditingController();
  var genderController = new TextEditingController();
  var contactNumberController = new TextEditingController();
  var bdController = new TextEditingController();
  var bmController = new TextEditingController();
  var byController = new TextEditingController();
  var bhController = new TextEditingController();
  var bmiController = new TextEditingController();
  var bsController = new TextEditingController();
  var bpController = new TextEditingController();



  var _error = "";
  var _success = "";


  Future expressInterest() async{
    
    var nameEntered = nameController.text;
    var genderEntered = genderController.text;
    var contactNumberEntered = contactNumberController.text;
    var bdEntered = bdController.text;
    var bmEntered = bmController.text;
    var byEntered = byController.text;
    var bhEntered = bhController.text;
    var bmiEntered = bmiController.text;
    var bsEntered = bsController.text;
    var bpEntered = bpController.text;
    var service = title;


    if(nameEntered==""||contactNumberEntered==""){
      setState(() {
        _error = "Please Enter Name and Contact Number";
      });
    }else{
      setState(() {
        _error = "";
      });
      var url = Constants.apiUrl+'record-service-interest';
      var response = await http.post(Uri.parse(url), body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678', 'name': nameEntered, 'gender': genderEntered ,'contact_number': contactNumberEntered,"birth_date": bdEntered,"birth_month": bmEntered,"birth_year":byEntered,"birth_hour":bhEntered,"birth_minute": bmiEntered,"birth_second": bsEntered,"birth_place": bpEntered, "service": service});

      if(response.statusCode==200){
        var responseBody = jsonDecode(response.body);
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
            _error = "Please check your Internet connection or try again later";
          });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(title, style: TextStyle(fontSize: 30.0)),
            SizedBox(
              height:10.0,
            ),
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: genderController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Gender",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: contactNumberController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Contact Number",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: bdController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Date",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: bmController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Month",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: byController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Year",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: bhController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Hour",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: bmiController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Minute",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: bsController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Second",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
                SizedBox(
                height: 20.0,
                ),
                TextFormField(
                  controller: bpController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Birth Place",
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )
                  ),
                ),
              ],  
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(_error,style: TextStyle(fontSize: 20.0,color: Colors.red),),
            Text(_success,style: TextStyle(fontSize: 20.0,color: Colors.green),),
            SizedBox(
              height: 5.0,
            ),
            MaterialButton(
              height: 50.0,
              minWidth: double.infinity,
              onPressed: expressInterest,
              color: Colors.blue,
              child: Text("Send",style: TextStyle(color: Colors.white,fontSize: 16.0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            SizedBox(height: 15.0,)
          ],
        ),
      ),      
    );
  }
}
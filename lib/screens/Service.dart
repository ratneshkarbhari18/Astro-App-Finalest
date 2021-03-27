import 'package:flutter/material.dart';
import '../templates/AppBarTemplate.dart';
import '../templates/DrawerTemplate.dart';
import '../templates/DrawerTemplateGeneral.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  List fields = ["name","gender","bd","bm","by","bh","bmi","bs","bp"];

  List fieldTitles = ["Name","Gender","Birth Date","Birth Month","Birth Year","Birth Hour","Birth Minute","Birth Second","Birth Place"];

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
              height: 10.0,
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              itemCount: fields.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
              return Container(
                child: Column(
                  children: [
                    SizedBox(
                    height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: fieldTitles[index],
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        )
                      ),
                    )
                  ],
                ),
              );
            },),
            SizedBox(height: 20,),
            MaterialButton(
              height: 50.0,
              minWidth: double.infinity,
              onPressed: (){},
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
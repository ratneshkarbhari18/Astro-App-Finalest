import 'package:flutter/material.dart';
import '../templates/DrawerTemplateGeneral.dart';
import '../templates/DrawerTemplate.dart';
import '../templates/AppBarTemplate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class TodaysHoroscope extends StatefulWidget {
  @override
  _TodaysHoroscopeState createState() => _TodaysHoroscopeState();
}

class _TodaysHoroscopeState extends State<TodaysHoroscope> {

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
        appBar: AppBarTemplate("Todays Horoscope"),
        body: DailyHoroscopePage(),
      ),
    );
  }
}

class DailyHoroscopePage extends StatefulWidget {
  @override
  _DailyHoroscopePageState createState() => _DailyHoroscopePageState();
}

class _DailyHoroscopePageState extends State<DailyHoroscopePage> {

  var _error = "";
  var horoscopes;
  var horoscopeData;
  var title = "";

  var allSigns = ["aries","taurus","gemini","cancer","leo","virgo","libra","scorpio","sagittarius","capricorn","aquarius","pisces"];


  Future getDailyHoroscope() async {

    DateTime todaysDate = DateTime.now();
    String todaysDateFormatted = DateFormat('dd-MM-yyyy').format(todaysDate);

    var url = Constants.apiUrl+"daily-horoscope-api";
    var uriParsed = Uri.parse(url);
    var response = await http.post(uriParsed, body: {'api_key': '5f4dbf2e5629d8cc19e7d51874266678', 'date': todaysDateFormatted});
    if(response.statusCode==200){
      var responseBody = jsonDecode(response.body);
      setState(() {
        horoscopeData = responseBody; 
        horoscopes = jsonDecode(responseBody["data"]);
        if(horoscopes==null){
          _error="Todays Horoscope not found";
        }
      });
      
    }else{
      setState(() {
        _error = "Could not connect to the internet.";
      });
    }
    return horoscopes;
  }

  @override
  void initState() {
    super.initState();
    getDailyHoroscope();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:20.0),
            (horoscopeData!=null)?Center(child:CircularProgressIndicator()):Padding(padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context,index){
              return (horoscopes!=null)?ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Text(allSigns[index].toUpperCase()+':',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Text(jsonDecode(horoscopes["data"])[allSigns[index]],style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 20.0,)            
                ],
              ):Text("No Horoscope found for today",style: TextStyle(color: Colors.red,fontSize: 30.0),);
          },itemCount: (horoscopes!=null)?12:1,),
            )
          ],
        ),
    );
  }
}
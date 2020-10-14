import 'dart:convert';

import 'package:ac_the_covid_tracker/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:ac_the_covid_tracker/datasorce.dart';
import 'package:http/http.dart' as http;
import 'package:ac_the_covid_tracker/pages/countryPage.dart';
import 'package:ac_the_covid_tracker/panels/infoPanel.dart';
import 'package:ac_the_covid_tracker/panels/mosteffectedcountries.dart';
import 'package:ac_the_covid_tracker/panels/OurPanel.dart';
import 'package:ac_the_covid_tracker/panels/worldwidepanel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final controller = ScrollController();
  double offset = 0;

  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }


  Future fetchData() async{
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    printno();
    controller.addListener(onScroll);
  }

  Future printno() async{
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    print('Phn No : '+pref2.getString("isPhn").toString());
  }

  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Worldwide',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CountryPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Global',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                    ),
                  ),
                ],
              ),
            ),

            worldData == null
                ? CircularProgressIndicator()
                : WorldwidePanel(
              worldData: worldData,
            ),
            Padding(
              padding: EdgeInsets.only(top:20.0),
              child: Center(
                child: Text(
                  'Our Country Stats:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            countryData == null
                ? Container()
                : OurPanel(
              countryData: countryData,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top:20.0),
              child: Center(
                child: Text(
                  'Most affected Countries',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            countryData == null
                ? Container()
                : MostAffectedPanel(
              countryData: countryData,
            ),
            Padding(
              padding: EdgeInsets.only(top:20.0),
            ),
            InfoPanel(),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
                  'WE ARE TOGETHER IN THE FIGHT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

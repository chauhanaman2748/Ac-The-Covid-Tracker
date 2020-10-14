import 'package:flutter/material.dart';
import 'package:ac_the_covid_tracker/pages/StatePage.dart';

class OurPanel extends StatelessWidget {
  final List countryData;

  const OurPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return countryData[index]['country']=='India'?Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.network(
                      countryData[index]['countryInfo']['flag'],
                      height: 45,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      countryData[index]['country'],
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Cases: ' + countryData[index]['cases'].toString(),
                      style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                )
              ],
            ),
          ):Container();
        },
        itemCount: 6,
      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => StatePage()));
      },
    );
  }
}

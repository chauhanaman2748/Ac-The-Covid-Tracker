import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ac_the_covid_tracker/pages/district.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class DistrictPage extends StatefulWidget {
  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<DistrictPage> {

  Future  onRefresh() async{

    Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(

            future: datas,
            builder: (BuildContext context,AsyncSnapshot snapshot){

              if(snapshot.hasData)
              {print(snapshot.data);
              return  GridView.builder(


                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0
                  ),
                  itemCount: 37,


                  itemBuilder: (BuildContext context, index) => SizedBox(


                      height : 50.0,
                      width : 50.0,
                      child: GestureDetector(
                          onTap:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => District(index)));
                          },
                          child: Card(
                            //elevation: 10,
                            // child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),

                            child: Container(color: Color(0xFF292929),
                                child : Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children : <Widget>[


                                        Padding(padding: EdgeInsets.all(10)),



                                        Text(snapshot.data[index]['state'],style: TextStyle(fontSize: 18,color: Colors.white),),



                                      ]
                                  ),)

                            ),

                          )
                      )
                  )
              );



              }
              return Center(
                child: CircularProgressIndicator(),
              );

            }


        )



    );
  }

  final String url = "https://api.covid19india.org/v2/state_district_wise.json";
  Future <List>  datas;

  Future <List>  getData() async
  {
    var response = await Dio().get(url);
    return response.data;
  }

  @override
  void initState()
  {
    super.initState();
    datas = getData();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
            title: Text('Statewise Statistics'),
            backgroundColor: Color(0xFF152238)

        ),
        body: RefreshIndicator(
          child: Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(

                  future: datas,
                  builder: (BuildContext context,AsyncSnapshot snapshot){

                    if(snapshot.hasData)
                    {print(snapshot.data);
                    return  GridView.builder(


                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0
                        ),
                        itemCount: 37,


                        itemBuilder: (BuildContext context, index) => SizedBox(


                            height : 50.0,
                            width : 50.0,
                            child: GestureDetector(
                                onTap:(){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => District(index)));
                                },
                                child: Card(
                                  //elevation: 10,
                                  // child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),

                                  child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [Colors.green, Colors.blue]
                                          )
                                      ),
                                      child : Center(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children : <Widget>[
                                              Padding(padding: EdgeInsets.only(top:5.0)),

                                              Text(snapshot.data[index]['state'],textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                                              Padding(padding: EdgeInsets.only(top:10.0)),

                                              Text('Stay Home,',
                                                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                              Text('Stay Safe',
                                                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                                              Text('And Save Lives',
                                                style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),

                                              Padding(padding: EdgeInsets.only(bottom:5.0)),

                                            ]
                                        ),)

                                  ),

                                )
                            )
                        )
                    );



                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  }


              )



          ), onRefresh: ()=>onRefresh()  ,

        )
    );
  }
}
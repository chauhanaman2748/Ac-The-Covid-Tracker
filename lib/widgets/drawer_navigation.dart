import 'package:ac_the_covid_tracker/pages/login.dart';
import 'package:ac_the_covid_tracker/screens/ABP.dart';
import 'package:ac_the_covid_tracker/screens/AajTak.dart';
import 'package:ac_the_covid_tracker/screens/Euro_news.dart';
import 'package:ac_the_covid_tracker/screens/NDTV.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ac_the_covid_tracker/screens/NDTV_English.dart';
import 'package:ac_the_covid_tracker/screens/Sky_news.dart';
import 'package:ac_the_covid_tracker/widgets/auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class DrawerNavigation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DR();
  }
}

class DR extends State<DrawerNavigation> {

  String phnNumber;
  String NameUser;
  String Name;
  var url;
  int endim;
  File _image;
  String im;
  String img='';
  var dwnUrl;
  ProgressDialog progressDialog;
  String isUser = '';

  Future _login() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getBool("isLogin")==false){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => new Login()));
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    print(_image);
  }

  Future takeImage() async {
    SharedPreferences pref4 = await SharedPreferences.getInstance();
    print("img ref "+pref4.getString("img"));

    setState(() {
      endim=pref4.getString("img").length;
      im=pref4.getString("img").substring(7,endim-1);
      _image=File(im);
    });
    print(_image);
  }

  Future setImage() async {
    SharedPreferences pref4 = await SharedPreferences.getInstance();
    print(img);
    print(_image);
    setState(() {
      pref4.setString("img", _image.toString());
      endim=pref4.getString("img").length;
    });
    print(img);
    print("end of image"+endim.toString());
  }

  Future logout() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    SharedPreferences pref3 = await SharedPreferences.getInstance();
    SharedPreferences pref4 = await SharedPreferences.getInstance();
    pref.setBool("isLogin", false);
    pref2.setString("isPhn", null);
    pref3.setString("isUser", null);
    pref4.setString("img", null);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => new Login()));
  }

  @override
  void initState() {
    super.initState();
    takeImage();
    _login();
    printno();
  }

  Future un() async{
    SharedPreferences pref3 = await SharedPreferences.getInstance();
      setState(() {
        pref3.setString("isUser", NameUser.toString());
        this.Name=pref3.getString("isUser").toString();
    });
    print('USER : '+pref3.getString("isUser").toString());
  }


  Future printno() async{
    SharedPreferences pref2 = await SharedPreferences.getInstance();
    SharedPreferences pref3 = await SharedPreferences.getInstance();
    setState(() {
    this.phnNumber= pref2.getString("isPhn").toString();
    this.Name=pref3.getString("isUser").toString();
    });
    print('USER : '+pref3.getString("isUser").toString());
    print('Phn No : '+pref2.getString("isPhn").toString());
    print('Phn No : '+phnNumber.toString());
    print('Path : '+url.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.deepPurple,
                      Colors.blue
                    ])
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.green,
                                    child: ClipOval(
                                      child: new SizedBox(
                                        width: 180.0,
                                        height: 180.0,
                                        child: (_image!=null)?Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        ): Icon(Icons.add_a_photo,color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                   getImage();

                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Welcome",style: TextStyle(fontSize: 25),),
                                SizedBox(height: 5),
                                Center(
                                  child: (Name.toString()!=null)?TextField(decoration: InputDecoration(hintText: '$Name'),
                                  onChanged: (value){
                                    this.NameUser=value;
                                  },):TextField(decoration: InputDecoration(hintText: 'Enter Username'),
                                    onChanged: (value){
                                      this.NameUser=value;
                                    },)
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text("User Phone Number : "+this.phnNumber.toString()),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text("Aaj Tak Live"),
                leading: Icon(Icons.desktop_windows,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return AajTak();
                  }));
                },
              ),
              ListTile(
                title: Text("ABP News Live"),
                leading: Icon(Icons.desktop_windows,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return ABP();
                  }));
                },
              ),
              ListTile(
                title: Text("NDTV Hindi Live"),
                leading: Icon(Icons.desktop_windows,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Ndtv();
                  }));
                },
              ),
              ListTile(
                title: Text("NDTV English Live"),
                leading: Icon(Icons.desktop_windows,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return NDTVEnglish();
                  }));
                },
              ),
              ListTile(
                title: Text("SKY News Live"),
                leading: Icon(Icons.desktop_windows,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return SkyNews();
                  }));
                },
              ),
              ListTile(
                title: Text("Euro News Live"),
                leading: Icon(Icons.desktop_windows,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return EuroNews();
                  }));
                },
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.person_outline,color: Colors.black,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return Auth();
                  }));
                },
              ),
              ListTile(
                title: Text("Log Out"),
                leading: Icon(Icons.lock,color: Colors.black,),
                onTap: (){
                  logout();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          setImage();
          un();
        },
        child: Image.asset("assets/ok.png"),
        backgroundColor: Colors.black,
      ),
    );
  }
}



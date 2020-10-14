import 'package:ac_the_covid_tracker/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/emma.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                                Colors.black,
                                Colors.black.withOpacity(.3)
                              ]
                          )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(1, Text("Aman Chauhan", style:
                            TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)
                              ,)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(1.6, Text("As a graduate student, I worked with all my wits on various other projects also.\nProjects like Superheroes, AcCloud, Auto Mailing and Biometric Lock are also having potential for the upliftment of the society.",
                          style: TextStyle(color: Colors.grey, height: 1.4),)),
                        SizedBox(height: 40,),
                        FadeAnimation(1.6,
                            Text("Born", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,
                            Text("May, 30th 2000, Gwalior, India", style: TextStyle(color: Colors.grey),)
                        ),
                        SizedBox(height: 20,),
                        FadeAnimation(1.6,
                            Text("Nationality", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,
                            Text("Indian", style: TextStyle(color: Colors.grey),)
                        ),
                        SizedBox(height: 20,),
                        FadeAnimation(1.6,
                            Text("Educational Qualifications", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,
                            Text("B.Tech, Sharda University, Gr. Noida(U.P.),India", style: TextStyle(color: Colors.grey),)
                        ),
                        SizedBox(height: 20,),
                        FadeAnimation(1.6,
                            Text("Hobbies", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,
                            Text("App Designing, Swimming, Badminton", style: TextStyle(color: Colors.grey),)
                        ),
                        SizedBox(height: 20,),
                        FadeAnimation(1.6,
                            Text("Language Known", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(height: 10,),
                        FadeAnimation(1.6,
                            Text("English, Hindi", style: TextStyle(color: Colors.grey),)
                        ),
                        SizedBox(height: 120,)
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
          /*Positioned.fill(
            bottom: 50,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FadeAnimation(2,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.yellow[700]
                    ),
                    child: Align(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFF102397),
                            Color(0xFF187adf),
                            Color(0xFF00eaf8),
                          ],
                          iconData: CustomIcons.facebook,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFFff4f38),
                            Color(0xFFff355d),
                          ],
                          iconData: CustomIcons.instagram,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea),
                          ],
                          iconData: CustomIcons.twitter,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF00c6fb),
                            Color(0xFF005bea),
                          ],
                          iconData: CustomIcons.linkedin,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          )*/
        ],
      ),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5/ 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.3)
                  ]
              )
          ),
          child: Align(
            child: Icon(Icons.play_arrow, color: Colors.white, size: 70,),
          ),
        ),
      ),
    );
  }
}


import 'package:ac_the_covid_tracker/constant.dart';
import 'package:ac_the_covid_tracker/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<Login> {
  Country _selected;
  String code;
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  ProgressDialog progressDialog;

  bool isLogin = false;
  String isPhn = '';

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
          smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (FirebaseUser phoneAuthCredential) async {
            SharedPreferences pref2 = await SharedPreferences.getInstance();
            pref2.setString("isPhn", phoneNo.toString());

            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setBool("isLogin", true);
            progressDialog.hide();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
          verificationFailed: (AuthException exception) {
            print('${exception.message}');
          }
      );
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) async {
                    if (user.toString() == this.smsOTP) {
                      SharedPreferences pref2 = await SharedPreferences.getInstance();
                      pref2.setString("isPhn", phoneNo.toString());

                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setBool("isLogin", true);
                      Navigator.of(context).pop();
                      progressDialog.hide();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential));
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      SharedPreferences pref2 = await SharedPreferences.getInstance();
      pref2.setString("isPhn", phoneNo.toString());

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogin", true);
      Navigator.of(context).pop();
      progressDialog.hide();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) async {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() async {
          SharedPreferences pref2 = await SharedPreferences.getInstance();
          pref2.setString("isPhn", '');

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool("isLogin", false);
          progressDialog.hide();
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() async {
          SharedPreferences pref2 = await SharedPreferences.getInstance();
          pref2.setString("isPhn", '');

          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setBool("isLogin", false);
          progressDialog.hide();
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.mainColor,
              AppColors.mainColor.withOpacity(.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            _buildHeader(),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Image.asset("assets/login/virus.png"),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .25,
              right: 25,
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Image.asset("assets/login/person.png"),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.asset("assets/login/logo.png"),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Positioned(
      bottom: 50,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Coronavirus disease (COVID-19)",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "is an infectianus disease caused by a new\nvirus.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                    child: Container(
                      width: 10,
                      child: CountryPicker(
                        showDialingCode: true,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                            this.code = country.dialingCode;
                          });
                        },
                        selectedCountry: _selected,
                      ),
                    )
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Number",
                        hintStyle: TextStyle(color: Colors.white)
                    ),
                    onChanged: (value){
                      this.phoneNo= "+"+this.code+value;
                    },
                  ),
                ),
                (errorMessage != ''
                    ? Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                )
                    : Container()),
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                progressDialog = ProgressDialog(context,type: ProgressDialogType.Download,);
                progressDialog.style(message: "Logging In");
                progressDialog.show();
                verifyPhone();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 1),
                      spreadRadius: 1,
                      blurRadius: 3,
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width * .85,
                height: 60,
                child: Center(
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

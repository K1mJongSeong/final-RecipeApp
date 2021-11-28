import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_flutter_app/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'next.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First app',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount user = _googleSignIn.currentUser;

    return Scaffold(
      backgroundColor: Color(0xFFF2ECD7),
      appBar: AppBar(
        title: Image.asset(
          'assets/images/appbar6.PNG',
          fit: BoxFit.fill,
          width: 1000,
        ),
        backgroundColor: (Color(0xFFCCCC99)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(30.0, 100.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image(
                      image: AssetImage(
                        "assets/images/icon3.PNG",
                      ),
                      width: 230,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    child: Theme(
                      data: ThemeData(
                          primaryColor: Colors.teal,
                          inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                  color: Colors.teal, fontSize: 15.0))),
                      child: Container(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton.extended(
                                icon: Image.asset(
                                  'assets/images/Google_logo.png',
                                  width: 30,
                                  height: 30,
                                ),
                                label: Text('Google Sign In'),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                // onPressed: () {
                                //   final provider =
                                //       Provider.of<GoogleSignInProvider>(context,
                                //           listen: false);
                                //   provider.googleLogin();
                                // }),
                                onPressed: () async {
                                  await _googleSignIn.signIn().whenComplete(() {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Next()));
                                  });
                                }),
                            // ElevatedButton(
                            //     child: Text('Sign Out'),
                            //     onPressed: () async {
                            //       await _googleSignIn.signOut();
                            //       //setState(() {});
                            //     }),
                            // TextField(
                            //   controller: controller,
                            //   decoration: InputDecoration(labelText: 'ID'),
                            //   keyboardType: TextInputType.emailAddress,
                            // ),
                            // TextField(
                            //   controller: controller2,
                            //   decoration: InputDecoration(labelText: 'PW'),
                            //   keyboardType: TextInputType.text,
                            //   obscureText: true,
                            // ),
                            // // Center(
                            // //   child: Column(
                            // //     children: [
                            // //       FlatButton(
                            // //         color: Colors.grey.withOpacity(0.3),
                            // //         onPressed: () {},
                            // //         child: Text("Google Login"),
                            // //       )
                            // //     ],
                            // //   ),
                            // // ),
                            // SizedBox(
                            //   height: 30.0,
                            // ),
                            // ButtonTheme(
                            //     minWidth: 300.0,
                            //     height: 50.0,
                            //     child: RaisedButton(
                            //         color: Color(0xFFCCCC99),
                            //         child: Icon(
                            //           Icons.login,
                            //           color: Colors.black,
                            //           size: 35.0,
                            //         ),
                            //         onPressed: () {
                            //           if (controller.text == 'Recipe' &&
                            //               controller2.text == 'rlawhdtjd') {
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder:
                            //                         (BuildContext context) =>
                            //                             Next()));
                            //           } else if (controller.text == 'Recipe' &&
                            //               controller2.text != 'rlawhdtjd') {
                            //             showSnackBar2(context);
                            //           } else if (controller.text != 'Recipe' &&
                            //               controller2.text == 'rlawhdtjd') {
                            //             showSnackBar3(context);
                            //           } else {
                            //             showSnackBar(context);
                            //           }
                            //         })),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

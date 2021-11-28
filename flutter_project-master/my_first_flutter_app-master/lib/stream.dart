import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:my_first_flutter_app/page/wirtePost.dart';

class Stream extends StatelessWidget {
  const Stream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Board();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something Went Wrong!!'));
            } else {
              return MyHomePage();
            }
          }),
    );
  }
}

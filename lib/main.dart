import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/material_white_color.dart';
import 'package:instagram_clone/data/provider/my_user_data.dart';
import 'package:instagram_clone/firebase/firestore_provider.dart';
import 'package:instagram_clone/main_page.dart';
import 'package:instagram_clone/screens/auth_page.dart';
import 'package:instagram_clone/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main(){
  return runApp(ChangeNotifierProvider<MyUserData>(
      create: (context) => MyUserData(),
      child: MyApp()));
}

bool isItFirstData = true;

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (isItFirstData) {
            isItFirstData = false;
            return MyProgressIndicator();
          } else {
            if (snapshot.hasData) {
              firestoreProvider.attemptCreateUser(userKey: snapshot.data.uid, email: snapshot.data.email);

              var myUserData = Provider.of<MyUserData>(context);

              firestoreProvider.connectMyUserData(snapshot.data.uid).listen((user){
                myUserData.setUserData(user);
              });
              
              return MainPage();
            }
            return AuthPage();
          }
        }
      ),
      theme: ThemeData(
          primarySwatch: white
      )
    );
  }
}

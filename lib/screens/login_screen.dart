import 'package:flutter/material.dart';
import 'package:mobilestore/screens/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {

static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _auth=FirebaseAuth.instance;
String email;
String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Form( 
        key:_key,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email=value;//Do something with the user input.
                },
                decoration:kTextFieldFormDecoration.copyWith( hintText: 'Enter your email',labelText: 'Email'),
               keyboardType: TextInputType.emailAddress,

              
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password=value;               },
                decoration: kTextFieldFormDecoration.copyWith( hintText: 'Enter your password.',labelText: 'Password')
              ),
              SizedBox(
                height:8.0,
              ),
               FlatButton(
                  onPressed: (){
                    if(_key.currentState.validate()){
                      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      
                    }
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password?'),
                ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: ()async {
                    
                    final user= await _auth.signInWithEmailAndPassword(email: email, password: password); 
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
                    ),
                  ),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}


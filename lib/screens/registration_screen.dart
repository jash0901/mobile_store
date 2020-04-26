import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mobilestore/data.dart';
import 'package:mobilestore/screens/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegistrationScreen extends StatefulWidget {
  static String id="registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController pass = TextEditingController();
  final TextEditingController cpass = TextEditingController();
  final _auth=FirebaseAuth.instance;
  String fname;
  String  lname;
  String mobile;
  String email;
  String password;
  String confirmpass;
  final _fr =Firestore.instance;

  Data data = Data();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
                          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged: (value){
                      fname=value;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(hintText:'First Name *',labelText: 'First Name'),
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                      WhitelistingTextInputFormatter(RegExp("[a-zA-z]"))
                    ],
                    validator: (value) => (value.length < 2) ? "First Name is Not Long Enough" : null,
                    onSaved: (value) => data.fname = value,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged:(value){
                      lname=value;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(hintText: 'Last Name *',labelText: 'Last Name'),

                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(20),
                      WhitelistingTextInputFormatter(RegExp("[a-zA-z]"))
                    ],
                    validator: (value) => (value.length < 2) ? "Last Name is Not Long Enough" : null,
                    onSaved: (value) => data.lname = value,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    onChanged: (value){
                      mobile=value;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(hintText: 'Mobile No. *',labelText:'Mobile No.'),
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.phone,
                    validator: (value) => (value.length < 10) ? "Mobile No. is Not Long Enough" : null,
                    onSaved: (value) => data.number = value,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    onChanged: (value){
                      email=value;
                    },
                    decoration: kTextFieldFormDecoration.copyWith( hintText: 'E-mail *',labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => (!EmailValidator.validate(value)) ? "Please Enter a Valid E-Mail" : null,
                    onSaved: (value) => data.email = value,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    onChanged: (value){
                      password=value;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(hintText: 'Password *',labelText: 'Password'),
                    controller: pass,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => (value.length < 6) ? "Please Enter a Valid Password" : null,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    onChanged: (value){
                      confirmpass=value;
                    },
                    decoration: kTextFieldFormDecoration.copyWith(hintText: 'Confirm Password *',labelText: 'Confirm Password'),

                    controller: cpass,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => (value != pass.text) ? "Password Does Not Match" : null,
                    onSaved: (value) => data.password = value,
                  ),
                  

                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async{
                          //Implement registration functionality.
                          if(_key.currentState.validate()){
                            _key.currentState.save();
                          }
                          print(data.fname);
                          print(data.lname);
                          print(data.number);
//print(data.email);
                         // print(data.password);
                       final newUser =await  _auth.createUserWithEmailAndPassword(email: email, password: password);
                       
                       await _fr.collection('users').add({
                      'Fname':fname,
                     'Lname':lname,
                      'Mobile':mobile,
                       });
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email,password,name;
  final formKey = GlobalKey<FormState>();
  bool  saveAttempted = false;

  void _createUser({String email, String pwd}){
    _auth.createUserWithEmailAndPassword(email: email, password: pwd).then((authResult) {
    print("Yo!! ${authResult.user}");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
            title: Text("#change me"),
        ),
           // body: Text("YO ! $name!"),
          body: Container(
            child: Column(
              children: <Widget>[
                Text("HELLO THERE!! WELCOME $name "),
//                RaisedButton(
//                  onPressed: (){
//                    _auth.signOut();
//                  },
//                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0)),
//                  color: Colors.green,
//                  child: Center(
//                    child: Text(
//                      'LOGOUT',
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.bold,
//                          fontFamily: 'Montserrat'),
//                    ),
//                  ),
//                )
              ],
            ),
          )

      );
    }
    )

    );
    }).catchError((e) {
      print(e.code);
      if(e.code == "ERROR_EMAIL_ALREADY_IN_USE"){
  showCupertinoDialog(context: context, builder: (context){
  return CupertinoAlertDialog(title: Text('This Email already has an account associated with PlayApp!! '),
  actions: <Widget>[
  CupertinoDialogAction(
  child: Text("OK"),
  onPressed: (){
  Navigator.pop(context);
  }
  )
  ],
  );
  });
  }
    });


  }//end of _createUser



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                    TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),


              //TODO : Form
              child: Form(

                //TODO : FormKeyy
                  key: formKey,

                child: Column(
                  children: <Widget>[

                    //TODO : EMAIL

                    TextFormField(
                      autovalidate: saveAttempted,
                      validator: (value){
                        // ignore: missing_return
                        if(value.isEmpty){
                              return 'This field can\'t be empty';
                        }

                        String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                            "\\@" +
                            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                            "(" +
                            "\\." +
                            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                            ")+";
                        RegExp regExp = new RegExp(p);

                        if (regExp.hasMatch(value)) {
                          // So, the email is valid
                          return null;
                        }

                        return 'This is not a valid email';
                      },

                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red
                          ),
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)) ),
                      onChanged: (textValue){
                        setState(() {
                          email = textValue;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),

                    //TODO: Password


                    TextFormField(
                      autovalidate: saveAttempted,
                      validator: (value){
                        // ignore: missing_return
                        if(value.isEmpty){
                          return 'This field can\'t be empty';
                        }
                        if(value.length < 6){
                          return 'Password must be atleast 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.red
                          ),
                          labelText: 'PASSWORD ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                      onChanged: (textValue){
                        setState(() {
                          password = textValue;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      autovalidate: saveAttempted,
                      validator: (value){
                        // ignore: missing_return
                        if(value.isEmpty){
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.red
                          ),
                          labelText: 'NICK NAME ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      onChanged: (textValue){
                        setState(() {
                          name = textValue;
                        });
                      },
                    ),
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                      //  child: Material(
//                          borderRadius: BorderRadius.circular(20.0),
//                          shadowColor: Colors.greenAccent,
                       // color: Colors.green,
//                          elevation: 7.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            //TODO: Firebase Auth
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                saveAttempted=true;
                              });
                            if(formKey.currentState.validate()) {
                              formKey.currentState.save();
                            print("Login Button pressed :) ");
                            _createUser(email: email,pwd: password);


                            }

                            },
                            child: Center(
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),

                            ),
                          ),
                    //    )
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child:

                          Center(
                            child: Text('Go Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),


                        ),
                      ),
                    ),
                  ],
                ),
              )),
          // SizedBox(height: 15.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text(
          //       'New to Spotify?',
          //       style: TextStyle(
          //         fontFamily: 'Montserrat',
          //       ),
          //     ),
          //     SizedBox(width: 5.0),
          //     InkWell(
          //       child: Text('Register',
          //           style: TextStyle(
          //               color: Colors.green,
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.bold,
          //               decoration: TextDecoration.underline)),
          //     )
          //   ],
          // )
        ]));
  }
}
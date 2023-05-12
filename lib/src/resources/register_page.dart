import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipe_food/src/blocs/auth_bloc.dart';
import 'package:recipe_food/src/resources/dialog/loading_dialog.dart';
import 'package:recipe_food/src/resources/home_page.dart';
import 'package:recipe_food/src/resources/login_page.dart';
import 'package:recipe_food/src/resources/dialog/msg_dialog.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  void dispose(){
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Image.asset(
                'assets/pink-324175__340.jpg',
                height: 120,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  "Welcome To Register Page",
                  style: TextStyle(fontSize: 22, color: Color(0xF5020205)),
                ),
              ),
              Text(
                "Signup with iFood in simple steps",
                style: TextStyle(fontSize: 16, color: Color(0xff1e1c1c)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _nameController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        labelText: "Name",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset('assets/ic_user.png'),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        labelText: "Email",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset('assets/ic_mail.png', width: 10, height: 10,),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.phoneStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _phoneController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        labelText: "Phone",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset('assets/ic_phone.png', width: 10, height: 10,),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: StreamBuilder(
                  stream: authBloc.passStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _passwordController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        labelText: "Password",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset('assets/ic_lock.png', width: 10, height: 10,),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onSignUpClicked,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: TextSpan(
                      text: "Already a account - ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage())
                                );
                              },
                            text: "Sign In",
                            style: TextStyle(color: Colors.green, fontSize: 16)
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSignUpClicked(){
    var isValid = authBloc.isValid(_nameController.text, _emailController.text, _passwordController.text, _phoneController.text);

    if(isValid){
      LoadingDialog.showLoadingDialog(context, 'Loading...');
        authBloc.signUp(_emailController.text, _passwordController.text, _phoneController.text, _nameController.text, (){
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }, (msg){
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, 'Sign-In', msg);
        });
    }
  }
}
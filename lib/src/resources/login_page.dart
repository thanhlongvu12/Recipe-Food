import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:recipe_food/src/blocs/auth_bloc.dart';
import 'package:recipe_food/src/resources/register_page.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  AuthBloc authBloc = new AuthBloc();


  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

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
                  "Welcome Back",
                  style: TextStyle(fontSize: 22, color: Color(0xF5020205)),
                ),
              ),
              Text(
                "Login to continue using app",
                style: TextStyle(fontSize: 16, color: Color(0xff1e1c1c)),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _emailController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Email",
                        errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset('assets/ic_mail.png'),
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
              StreamBuilder(
                stream: authBloc.passStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _passwordController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("assets/ic_lock.png", width: 10, height: 10,),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      ),
                    );
                }
              ),
              Container(
                // constraints: BoxConstraints.loose(Size(double.infinity, 30)),
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onClickLogin,
                    child: Text(
                      "Log In",
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
                    text: "New Account ?",
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
                                  MaterialPageRoute(builder: (context) => RegisterPage())
                                );
                            },
                        text: "Create new account",
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

  void onClickLogin(){
    var isValid = authBloc.isValidLogin(_emailController.text, _passwordController.text);
  }
}

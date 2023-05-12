import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class FirAuth{

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone, Function onSuccess, Function(String) onRegisterError){
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user){
          creatUser(user?.user?.uid, name!, phone!, onSuccess, onRegisterError);
          print(user);
  }).catchError((err){
    checkErrorSignUp(err.code, onRegisterError);
  });
  }

  void signIn(String email, String pass, Function onSuccess, Function(String) onSignInError){
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((user){
      print("SignIn on success");
      onSuccess();
    }).catchError((err){
      onSignInError("SignIn fail, please try again");
    });
  }

  creatUser(dynamic userID, String name, String phone, Function onSuccess, Function(String) onRegisterError){
    var user = {
      "name" : name,
      "phone" : phone,
    };
    var refe = FirebaseDatabase.instance.ref().child("users");
    refe.child(userID).set(user).then((user){
      onSuccess();
    }).catchError((err){
      onRegisterError("Signup fail, please try again");
    });
  }

  void checkErrorSignUp(String code, Function(String) onRegisterError){
    switch(code){
      case "invalid-email":
        onRegisterError("Invalid Email");
        break;
      case "email-already-in-use":
        onRegisterError("Email has existed");
        break;
      case "weak-password":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("Signup Fail, please try again");
        break;
    }
  }
}
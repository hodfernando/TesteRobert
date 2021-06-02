
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/models/user_model.dart';

enum signTokens {
  signUP,
  Find,
  NotFind,
  wrongPass
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  void onSuccess(){}
  void onFail(){}

  try{
    group('signUp', () {
      test('existing user signUp', () {
        try {
          UserModel userModel = UserModel();
          userModel.signUp(
              userData: {'nome': 'fernando', 'email': 'fernando@gmail.com'},
              pass: '123456',
              onSuccess: onSuccess,
              onFail: onFail);
          expect(userModel.isLoggedIn(), false);
          //throw signTokens.Find;
        }catch(e){
          throw signTokens.signUP;
        }
      });
    });
  }catch(e, s){
    rethrow;
  }
  try{
    group('signIn', () {
      /*test('existing user signIn', () {
        //UserModel userModel = UserModel();
        //userModel.signIn(email: 'fernando@gmail.com', pass: '123456', onSuccess: onSuccess, onFail: onFail);
        FirebaseAuth _auth = FirebaseAuth.instance;
        FirebaseUser firebaseUser;
        _auth.signInWithEmailAndPassword(email: 'fernando@gmail.com', password: '123456')
            .then( (user) async {
          firebaseUser = user;
          if(firebaseUser == null)
            firebaseUser = await _auth.currentUser();
        }).catchError((e){
          throw e;
        });
        expect(firebaseUser, isNotNull);
        //throw signTokens.Find;
      });*/
      test('non-existent use signIn', () {
        try{
          UserModel userModel = UserModel();
          userModel.signIn(email: 'geraldo@gmail.com', pass: '55555555', onSuccess: onSuccess, onFail: onFail);
          expect(userModel.isLoggedIn(), false);
        }catch(e, s){
          throw signTokens.NotFind;
        }
      });
      test('existing user, wrong password signIn', () {
        try{
          UserModel userModel = UserModel();
          userModel.signIn(email: 'fernando@gmail.com', pass: '666666', onSuccess: onSuccess, onFail: onFail);
          expect(userModel.isLoggedIn(), false);
      }catch(e, s){
        throw signTokens.wrongPass;
      }
      });
    });
  }catch(e, s){
    rethrow;
  }
}

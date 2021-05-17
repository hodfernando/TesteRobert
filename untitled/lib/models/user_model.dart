import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled/screens/signup_screen.dart';
import 'dart:async';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp({@required Map<String, dynamic> userData, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async{
    isLoading = true;
    notifyListeners();
    _auth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: pass,
    ).then((user) async {
      firebaseUser = user;
      await _saveUserData(userData);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((error){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }
  void signIn() async{
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  void signOut() async{

    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(){
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  void sendMessage({@required Map<String, dynamic> sendData,
  @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    if(sendData['value'] != null) {
      Map<String, dynamic> data = {
        "uid": firebaseUser.uid,
        "valor": sendData['value'],
        "mensagem": sendData['message'],
      };
      await Firestore.instance.collection("valores").add(data);
      onSuccess();
    } else onFail();
    isLoading = false;
    notifyListeners();
  }
}
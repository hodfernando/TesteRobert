import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
        child: MaterialApp(
          title: 'Flutter Teste',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.deepPurple,
          ),
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        ),
    );
  }
}

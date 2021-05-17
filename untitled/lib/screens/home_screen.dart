import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:untitled/models/user_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:untitled/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  //final TextEditingController _controller = TextEditingController();

  final _textController = TextEditingController();
  final _valueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static const _locale = 'pt_br';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  String get _currency =>
      NumberFormat
          .compactSimpleCurrency(locale: _locale)
          .currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela principal'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          /*if(!model.isLoggedIn())
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen())
            );*/
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                SizedBox(height: 16.0,),
                Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(height: 16.0,),
                TextFormField(
                  controller: _valueController,
                  decoration: InputDecoration(
                      prefixText: _currency,
                      hintText: "Valor",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (string) {
                    string = '${_formatNumber(string.replaceAll(',', ''))}';
                    _valueController.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                  validator: (text) {
                    if (text.isEmpty) return "Sem valor a ser enviado!";
                  },
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: "Mensagem"
                  ),
                  validator: (text) {
                    if (text.isEmpty) return "Sem mensagem a ser enviada!";
                  },
                ),
                SizedBox(height: 16.0,),
                RaisedButton(
                  child: Text("Enviar transação",
                    style: TextStyle(fontSize: 18.0,),
                  ),
                  textColor: Colors.white,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> sendData = {
                        "value": _valueController.text,
                        "message": _textController.text
                      };
                      model.sendMessage(
                          sendData: sendData,
                          onSuccess: _onSuccess,
                          onFail: _onFail
                      );
                      _valueController.clear();
                      _textController.clear();
                    }
                  },
                ),
                SizedBox(height: 16.0,),
                Divider(),
                SizedBox(height: 16.0,),
                FlatButton(
                  child: Text("Sair"),
                  onPressed: (){
                    model.signOut();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
  }

  void _onFail() {
  }
}
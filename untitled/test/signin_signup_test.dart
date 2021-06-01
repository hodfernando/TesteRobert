
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/models/user_model.dart';

enum signTokens {
  Find,
  NotFind,
  wrongPass
}

void main() {

  void onSuccess(){}
  void onFail(){}

  try{
    group('sigIn', () {
      test('existing user', () {
        final userModel = UserModel();
        userModel.signIn(email: 'fernando@gmail.com', pass: '123456', onSuccess: onSuccess, onFail: onFail);
        throw signTokens.Find;
      });
      test('non-existent use', () {
        final userModel = UserModel();
        userModel.signIn(email: 'geraldo@gmail.com', pass: '55555555', onSuccess: onSuccess, onFail: onFail);
        throw signTokens.NotFind;
      });
      test('existing user, wrong password', () {
        final userModel = UserModel();
        userModel.signIn(email: 'fernando@gmail.com', pass: '666666', onSuccess: onSuccess, onFail: onFail);
        throw signTokens.wrongPass;
      });
    });
  }catch(e, s){
    rethrow;
  }

}

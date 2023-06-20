import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager/common/routes/routes.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  void verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: smsCodeId, smsCode: smsCode);

      await auth.signInWithCredential(credential);

      if(!mounted){
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
    } on FirebaseAuth catch (e) {
      print(e.toString());
    }
  }
}

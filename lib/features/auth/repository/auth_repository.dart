import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/helpers/db_helper.dart';
import 'package:task_manager/common/routes/routes.dart';
import 'package:task_manager/common/widgets/show_dialogue.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

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
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);

      await auth.signInWithCredential(credential);

      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialogue(context: context, message: e.toString());
    }
  }

  void sendOtp(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialogue(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendCodeId) {
            DBHelper.createUser(1);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.OTP, (route) => false, arguments: {
              'phoneNumber': phoneNumber,
              'smsCodeId': smsCodeId
            });
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuth catch (e) {
      showAlertDialogue(context: context, message: e.toString());
    }
  }
}

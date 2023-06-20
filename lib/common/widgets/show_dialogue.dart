import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';

showAlertDialogue(
    {required BuildContext context, required String message, String? btnText}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ReusableText(
            text: message,
            style: appStyle(18, AppConst.kLight, FontWeight.w600),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                btnText ?? "Close",
                style: appStyle(16, AppConst.kGreyLight, FontWeight.w300),
              ),
            )
          ],
        );
      });
}

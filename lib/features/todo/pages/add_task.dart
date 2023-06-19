import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_btn_otl.dart';
import 'package:task_manager/common/widgets/custom_text_field.dart';
import 'package:task_manager/common/widgets/height_spacer.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ReusableText(
            text: "Add Task",
            style: appStyle(18, AppConst.kLight, FontWeight.normal)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            HeightSpacer(height: 15.h),
            CustomTextField(
              hintText: "Title",
              controller: title,
              hintStyle: appStyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            HeightSpacer(height: 15.h),
            CustomTextField(
              hintText: "Description",
              controller: description,
              hintStyle: appStyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            HeightSpacer(height: 15.h),
            CustomOutlineButton(
              width: AppConst.kWidth,
              height: 52.h,
              color: AppConst.kBlueLight,
              text: "Set Date",
            ),
            HeightSpacer(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineButton(
                  width: AppConst.kWidth * 0.42,
                  height: 52.h,
                  color: AppConst.kBlueLight,
                  text: "Start Time",
                ),
                CustomOutlineButton(
                  width: AppConst.kWidth * 0.42,
                  height: 52.h,
                  color: AppConst.kBlueLight,
                  text: "End Time",
                ),
              ],
            ),
            HeightSpacer(height: 15.h),
            CustomOutlineButton(
              width: AppConst.kWidth,
              height: 52.h,
              color: AppConst.kLight,
              color2: AppConst.kBlueLight,
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}

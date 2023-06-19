import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_btn_otl.dart';
import 'package:task_manager/common/widgets/custom_text_field.dart';
import 'package:task_manager/common/widgets/height_spacer.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';

import '../controllers/dates/dates_provider.dart';

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
    var scheduleDate = ref.watch(datesStateProvider);
    var scheduleStartTime = ref.watch(startTimeStateProvider);
    var scheduleEndTime = ref.watch(endTimeStateProvider);

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
              onTap: () {
                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 6, 1),
                    maxTime: DateTime(2024, 6, 1),
                    theme: const picker.DatePickerTheme(
                      doneStyle:
                          TextStyle(color: AppConst.kBlueLight, fontSize: 16),
                    ), onConfirm: (date) {
                  ref
                      .read(datesStateProvider.notifier)
                      .setDate(date.toString());
                }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
              },
              width: AppConst.kWidth,
              height: 52.h,
              color: AppConst.kBlueLight,
              text: scheduleDate == ""
                  ? "Set Date"
                  : scheduleDate.substring(0, 10),
            ),
            HeightSpacer(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineButton(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                      ref
                          .read(startTimeStateProvider.notifier)
                          .setStartTime(date.toString());
                    }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth * 0.42,
                  height: 52.h,
                  color: AppConst.kBlueLight,
                  text: scheduleStartTime == ""
                      ? "Start Time"
                      : scheduleStartTime.substring(10, 16),
                ),
                CustomOutlineButton(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                          ref
                              .read(endTimeStateProvider.notifier)
                              .setEndTime(date.toString());
                        }, locale: picker.LocaleType.en);
                  },
                  width: AppConst.kWidth * 0.42,
                  height: 52.h,
                  color: AppConst.kBlueLight,
                  text: scheduleEndTime == ""
                      ? "End Time"
                      : scheduleEndTime.substring(10, 16),
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

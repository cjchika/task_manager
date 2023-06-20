import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_btn_otl.dart';
import 'package:task_manager/common/widgets/height_spacer.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';

import '../../../common/widgets/custom_text_field.dart';
import 'otp_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'USA',
    example: 'USA',
    displayName: 'United States',
    displayNameNoCountryCode: 'US',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset("assets/images/todo.png", width: 300),
              ),
              const HeightSpacer(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16.w),
                child: Center(
                  child: ReusableText(
                    text: "Please enter your phone number",
                    style: appStyle(17, AppConst.kLight, FontWeight.w500),
                  ),
                ),
              ),
              const HeightSpacer(height: 20),
              Center(
                child: CustomTextField(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              backgroundColor: AppConst.kBkDark,
                              textStyle: appStyle(16, AppConst.kLight, FontWeight.w500),
                              inputDecoration: InputDecoration(hintStyle: appStyle(16, AppConst.kLight, FontWeight.w600)),
                              bottomSheetHeight: AppConst.kHeight * 0.6,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.5),
                                topRight: Radius.circular(10.5),
                              ),
                            ),
                            onSelect: (code) => setState(() {}));
                      },
                      child: ReusableText(
                        text: "${country.flagEmoji} + ${country.phoneCode}",
                        style: appStyle(18, AppConst.kBkDark, FontWeight.bold),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  hintText: "Enter phone number",
                  hintStyle: appStyle(16, AppConst.kBkDark, FontWeight.w600),
                ),
              ),
              const HeightSpacer(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOutlineButton(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpPage(smsCodeId: '', phoneNumber: '',)));
                  },
                  width: AppConst.kWidth * 0.9,
                  height: AppConst.kHeight * 0.07,
                  color: AppConst.kBkDark,
                  color2: AppConst.kLight,
                  text: "Send Code",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

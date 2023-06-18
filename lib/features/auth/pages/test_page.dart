import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';
import 'package:task_manager/features/auth/controllers/code_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String text = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ReusableText(
                text: text,
                style: appStyle(30, AppConst.kLight, FontWeight.bold)),
            TextButton(onPressed: () {
              ref.read(codeStateProvider.notifier).setStart("Another one!");
            }, child: Text("Click 🤑", style: appStyle(30, AppConst.kLight, FontWeight.w600),))
          ],
        ),
      ),
    );
  }
}

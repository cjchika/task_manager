import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/features/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/xpansion_tile.dart';
import '../controllers/xpansion_provider.dart';
import '../pages/update_task.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(todoStateProvider);
    String tomorrowDate = ref.read(todoStateProvider.notifier).getTomorrow();
    final color = ref.read(todoStateProvider.notifier).getRandomColor();
    var tomorrowTasks =
        tasks.where((element) => element.date!.contains(tomorrowDate));

    return XpansionTile(
      text: "Tomorrow's Task",
      text2: "Upcoming tasks show here.",
      onExpansionChanged: (bool expanded) =>
          ref.read(xpansionStateProvider.notifier).setStart(!expanded),
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.0.w),
        child: ref.watch(xpansionStateProvider)
            ? const Icon(
                AntDesign.circledown,
                color: AppConst.kLight,
              )
            : const Icon(
                AntDesign.closecircleo,
                color: AppConst.kBlueLight,
              ),
      ),
      children: [
        for (final task in tomorrowTasks)
          ToDoTile(
            title: task.title,
            description: task.desc,
            color: color,
            start: task.startTime,
            end: task.endTime,
            switcher: const SizedBox.shrink(),
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTask(task.id ?? 0);
            },
            editWidget: GestureDetector(
              onTap: () {
                taskTitle = task.title.toString();
                taskDesc = task.desc.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTask(
                      id: task.id ?? 0,
                      title: taskTitle,
                      desc: taskDesc,
                    ),
                  ),
                );
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
          )
      ],
    );
  }
}

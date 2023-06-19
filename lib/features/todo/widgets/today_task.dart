import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/features/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';

class TodayTask extends ConsumerWidget {
  const TodayTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> todoList = ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    var todoToday = todoList
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();

    return ListView.builder(
        itemCount: todoToday.length,
        itemBuilder: (context, index) {
          final data = todoToday[index];
          bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);

          return ToDoTile(
            title: data.title,
            color: AppConst.kGreen,
            description: data.desc,
            start: data.startTime,
            end: data.endTime,
            switcher: Switch(value: isCompleted, onChanged: (value) => {})
          );
        });
  }
}

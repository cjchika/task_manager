import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/features/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({super.key});

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
          bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(
              data);
          dynamic color = ref.read(todoStateProvider.notifier).getRandomColor()
          ;
          return ToDoTile(
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTask(data.id ??0);
              },
              editWidget: GestureDetector(onTap: () {},
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),),
              title: data.title,
              color: color,
              description: data.desc,
              start: data.startTime,
              end: data.endTime,
              switcher: Switch(value: isCompleted, onChanged: (value) => {})
          );
        });
  }
}

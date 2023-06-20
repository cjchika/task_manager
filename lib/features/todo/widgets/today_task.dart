import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/features/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../pages/update_task.dart';

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
          final task = todoToday[index];
          bool isCompleted =
              ref.read(todoStateProvider.notifier).getStatus(task);
          dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
          return ToDoTile(
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
            title: task.title,
            color: color,
            description: task.desc,
            start: task.startTime,
            end: task.endTime,
            switcher: Switch(
              value: isCompleted,
              onChanged: (value) =>
                  ref.read(todoStateProvider.notifier).markAsCompleted(
                        task.id ?? 0,
                        task.title.toString(),
                        task.desc.toString(),
                        task.isCompleted ?? 1,
                        task.date.toString(),
                        task.startTime.toString(),
                        task.endTime.toString(),
                      ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/features/todo/controllers/todo/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

import '../../../common/models/task_model.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> todoList = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).getLast30Days();
    var completedTasks = todoList
        .where((element) =>
    element.isCompleted == 1 || lastMonth.contains(element.date!.substring(0,10)))
        .toList();

    return ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final data = completedTasks[index];
          dynamic color = ref.read(todoStateProvider.notifier).getRandomColor()
          ;
          return ToDoTile(
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTask(data.id ??0);
              },
              editWidget: const SizedBox.shrink(),
              title: data.title,
              color: color,
              description: data.desc,
              start: data.startTime,
              end: data.endTime,
              switcher: const Icon(AntDesign.checkcircle, color: AppConst.kGreen,)
          );
        });
  }
}

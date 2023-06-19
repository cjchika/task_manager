import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager/common/helpers/db_helper.dart';
import 'package:task_manager/common/models/task_model.dart';
part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState{
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getTasks();
    state = data.map((e) => Task.fromJson(e)).toList();
  }

  void addTask(Task task) async {
    await DBHelper.createTask(task);
    refresh();
  }

  void updateTask(int id, String title, String desc,
      int isCompleted, String date, String startTime, String endTime) async {
    await DBHelper.updateTask(id, title, desc, isCompleted, date, startTime, endTime);
    refresh();
  }
}

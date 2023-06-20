import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/helpers/db_helper.dart';
import 'package:task_manager/common/models/user_model.dart';

final userProvider = StateNotifierProvider<UserState, List<UserModel>>((ref) {
  return UserState();
});

class UserState extends StateNotifier<List<UserModel>>{
  UserState() : super([]);

  void refresh() async {
    final users = await DBHelper.getUsers();

    state = users.map((e) => UserModel.fromJson(e)).toList();
  }
}
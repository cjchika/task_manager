import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dates_provider.g.dart';

@riverpod
class DatesState extends _$DatesState{
  @override
  String build() {
    return "";
  }

  void setDate(String newState) {
    state = newState;
  }
}

@riverpod
class StartTimeState extends _$StartTimeState{
  @override
  String build() {
    return "";
  }

  void setStartTime(String newState) {
    state = newState;
  }
}

@riverpod
class EndTimeState extends _$EndTimeState{
  @override
  String build() {
    return "";
  }

  void setEndTime(String newState) {
    state = newState;
  }
}
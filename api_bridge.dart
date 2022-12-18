import 'package:pigeon/pigeon.dart';

enum MarkType { exam, practise, credit }

class ScheduleOfExam {
  ScheduleOfExam(
      {required this.mark,
      required this.dateTime,
      required this.name,
      required this.room,
      this.teachers});
  MarkType mark;
  String dateTime;
  String name;
  List<String?>? teachers;
  String room;
}

@HostApi()
abstract class ScheduleAPI {
  List<ScheduleOfExam> getAllGroups(Uint8List file);
  ScheduleOfExam getGroupByName(Uint8List file, String name);
}

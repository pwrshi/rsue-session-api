import 'package:pigeon/pigeon.dart';

enum MarkType { exam, practise, credit }

class SubjectInfo {
  SubjectInfo(
      {required this.mark,
      required this.dateTime,
      required this.name,
      this.rooms,
      this.teachers});
  MarkType mark;
  String dateTime;
  String name;
  List<String?>? teachers;
  List<String?>? rooms;
}

class GroupSchedule {
  GroupSchedule({required this.name, required this.exams});
  String name;
  List<SubjectInfo?> exams;
}

@HostApi()
abstract class ScheduleAPI {
  List<GroupSchedule> getAllGroups(Uint8List file);
  GroupSchedule getGroupByName(Uint8List file, String name);
}

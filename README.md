# rsue_session_api

Маленькая библиотечка для получения списка экзаменов для каждой очной группы университета РГЭУ(РИНХ)

## Как работать

Метод getAllSchedules вернёт все экзамены для каждой группы
Метод getGroupSchedule вернёт конкретное расписание по имени группы, переданное в аргументы

```dart
Future<List<GroupSchedule?>> RsueSessionApi.getAllSchedules();
Future<GroupSchedule?> getGroupSchedule(String name);
```

Само расписание содержит только имя и список экзаменов:

```dart
class GroupSchedule {
  GroupSchedule({required this.name, required this.exams});
  String name;
  List<SubjectInfo?> exams;
}
```

А предмет состоит из:

```dart
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
```
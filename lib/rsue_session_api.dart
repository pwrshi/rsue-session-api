import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:rsue_session_api/api.dart';

class RsueSessionApi {
  Future<List<GroupSchedule?>> getAllSchedules() async {
    var data = (await Dio().get("https://rsue.ru/studentam/rasp-ekz-of/"))
        .data
        .toString();
    var parseddata = parse(data);
    var links = parseddata
        .querySelectorAll(".col-lg-6.col-md-6.col-sm-6")
        .map((e) => e.querySelectorAll("li>a"))
        .expand<Element>((element) => element)
        .map<String?>((e) => e.attributes["href"]);
    List<GroupSchedule?> result = [];
    for (var link in links) {
      if (!link!.contains("xlsx")) {
        var doc = await Dio().get<Uint8List>("https://rsue.ru/${link!}",
            options: Options(responseType: ResponseType.bytes));
        var items = await ScheduleAPI().getAllGroups(doc.data!);
        result.addAll(items);
      }
    }
    return result;
  }
}

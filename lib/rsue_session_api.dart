import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rsue_session_api/api.dart';
import 'rsue_session_api_platform_interface.dart';

class RsueSessionApi {
  Future<List<GroupSchedule?>> getScheduleOfExams() async {
    var resp = await Dio().get<Uint8List>(
        "https://rsue.ru/studentam/rasp-ekz-of/doc/3/2%20%D0%BA%D1%83%D1%80%D1%81.xls",
        options: Options(responseType: ResponseType.bytes));
    var result = await ScheduleAPI().getAllGroups(resp.data!);

    return result;
  }

  Future<String?> getPlatformVersion() async {
    return RsueSessionApiPlatform.instance.getPlatformVersion();
  }
}

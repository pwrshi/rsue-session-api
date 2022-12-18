import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rsue_session_api/api.dart';
import 'rsue_session_api_platform_interface.dart';

class RsueSessionApi {
  Future<ScheduleOfExam?> getScheduleOfExams() async {
    var resp = await Dio().get<ResponseBody>(
        "https://rsue.ru/studentam/rasp-ekz-of/doc/3/2%20%D0%BA%D1%83%D1%80%D1%81.xls",
        options: Options(responseType: ResponseType.stream));

    return null;
  }

  Future<String?> getPlatformVersion() async {
    return RsueSessionApiPlatform.instance.getPlatformVersion();
  }
}

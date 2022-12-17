import 'package:flutter_test/flutter_test.dart';
import 'package:rsue_session_api/rsue_session_api.dart';
import 'package:rsue_session_api/rsue_session_api_platform_interface.dart';
import 'package:rsue_session_api/rsue_session_api_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRsueSessionApiPlatform
    with MockPlatformInterfaceMixin
    implements RsueSessionApiPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RsueSessionApiPlatform initialPlatform = RsueSessionApiPlatform.instance;

  test('$MethodChannelRsueSessionApi is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRsueSessionApi>());
  });

  test('getPlatformVersion', () async {
    RsueSessionApi rsueSessionApiPlugin = RsueSessionApi();
    MockRsueSessionApiPlatform fakePlatform = MockRsueSessionApiPlatform();
    RsueSessionApiPlatform.instance = fakePlatform;

    expect(await rsueSessionApiPlugin.getPlatformVersion(), '42');
  });
}

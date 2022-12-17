import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rsue_session_api/rsue_session_api_method_channel.dart';

void main() {
  MethodChannelRsueSessionApi platform = MethodChannelRsueSessionApi();
  const MethodChannel channel = MethodChannel('rsue_session_api');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

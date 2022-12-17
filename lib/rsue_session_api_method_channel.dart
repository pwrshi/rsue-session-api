import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rsue_session_api_platform_interface.dart';

/// An implementation of [RsueSessionApiPlatform] that uses method channels.
class MethodChannelRsueSessionApi extends RsueSessionApiPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rsue_session_api');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

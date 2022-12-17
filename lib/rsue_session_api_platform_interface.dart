import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rsue_session_api_method_channel.dart';

abstract class RsueSessionApiPlatform extends PlatformInterface {
  /// Constructs a RsueSessionApiPlatform.
  RsueSessionApiPlatform() : super(token: _token);

  static final Object _token = Object();

  static RsueSessionApiPlatform _instance = MethodChannelRsueSessionApi();

  /// The default instance of [RsueSessionApiPlatform] to use.
  ///
  /// Defaults to [MethodChannelRsueSessionApi].
  static RsueSessionApiPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RsueSessionApiPlatform] when
  /// they register themselves.
  static set instance(RsueSessionApiPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

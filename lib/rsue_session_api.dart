
import 'rsue_session_api_platform_interface.dart';

class RsueSessionApi {
  Future<String?> getPlatformVersion() {
    return RsueSessionApiPlatform.instance.getPlatformVersion();
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceUuid {
  Future<String> getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // UUID가 저장되어 있지 않은 경우에는 새 UUID 생성
    String uuid = prefs.getString('uuid') ?? const Uuid().v4();
    // 생성된 UUID를 SharedPreferences에 저장
    prefs.setString('uuid', uuid);

    print("[deviceUuid.dart] (getUUID) your uuid : $uuid");
    return uuid;
  }
}

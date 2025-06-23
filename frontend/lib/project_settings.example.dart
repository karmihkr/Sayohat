import 'package:shared_preferences/shared_preferences.dart';

class ProjectSettings {
  String apiUrl = "API_URL/API_HOST_PORT";
  bool localHosted = true;
}


var projectSettings = ProjectSettings();
var persistentStorage = SharedPreferencesAsync();

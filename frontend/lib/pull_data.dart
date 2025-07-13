import 'package:sayohat/api_clients/hamsafar_api_client.dart';
import 'package:sayohat/objects/current_rides.dart';
import 'package:sayohat/objects/current_user.dart';
import 'package:sayohat/project_settings.dart';

import 'models/ride_model.dart';
import 'models/user_model.dart';

Future<void> pullData() async {
  if (await persistentStorage.getString("currentUser") == null) {
    await persistentStorage.setString(
      "currentUser",
      await hamsafarApiClient.getUserProfile(),
    );
  }
  currentUser = User.fromJsonString(
    await persistentStorage.getString("currentUser"),
  );
  if (await persistentStorage.getStringList("currentRides") == null) {
    await persistentStorage.setStringList(
      "currentRides",
      await hamsafarApiClient.getUserRides(),
    );
  }
  for (final jsonString in (await persistentStorage.getStringList("currentRides"))!) {
    currentRides.add(Ride.fromJsonString(jsonString));
  }
}

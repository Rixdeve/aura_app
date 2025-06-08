import 'package:connectivity_plus/connectivity_plus.dart';

Future<String> checkConnectionStatus() async {
  var result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.mobile) {
    return "Connected to Interet";
  } else if (result == ConnectivityResult.wifi) {
    return "Connected to Internet";
  } else {
    return "No Internet";
  }
}

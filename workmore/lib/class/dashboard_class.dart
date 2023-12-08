import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workmore/api/api.dart';
import 'package:workmore/ui/popup/reason_dialog.dart';
import 'package:geolocator/geolocator.dart' as locator;
import 'package:location/location.dart' as loc;

String _timeString = '';
String reason = "-";

bool status(String timein) {
  DateTime timeInConfig = DateTime.parse("0000-00-00 08:00:00");
  DateTime timeInInput = DateTime.parse("0000-00-00 $timein");

  if (timeInInput.compareTo(timeInConfig) != 1) {
    return true;
  } else {
    return false;
  }
}

Future<void> getAbsenData(
    BuildContext context, String dateData, String _timeString) async {
  MyApi myApi = MyApi('param1', 'param1', {'data': 'data'});
  final response = await myApi.Get();
  if (response.length != 0) {
    if (response["data"] == null) {
      if (!status(_timeString)) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ReasonDialog(
              onPressed: (reason) {
                sendAbsenData("time_in", _timeString, reason);
                Navigator.of(context).pop();
              },
            );
          },
        );
      } else {
        sendAbsenData("time_in", _timeString, "");
      }
    } else {
      if (response["data"]["time_in"] != null &&
          response["data"]["time_out"] == null) {
        updateAbsenData("time_out", _timeString, dateData);
      } else if (response["data"]["time_out"] == null &&
          response["data"]["time_out"] == null) {
        Fluttertoast.showToast(
          msg: "Something wrong with absent data.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Today record have complete.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        );
      }
    }
  } else {
    Fluttertoast.showToast(
      msg: "Get absent data failed.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}

Future<void> sendAbsenData(String param, String data, String? reason) async {
  MyApi myApi = MyApi('param1', 'param1', {'data': 'data'});
  final response = await myApi.Post();

  if (response) {
    Fluttertoast.showToast(
      msg: "Clock in Success.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  } else {
    Fluttertoast.showToast(
      msg: "Clock in Failed.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}

Future<void> updateAbsenData(String param, String data, String dateData) async {
  MyApi myApi = MyApi('param1', 'param1', {'data': 'data'});
  final response = await myApi.Post();

  if (response) {
    Fluttertoast.showToast(
      msg: "Clock out Success.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  } else {
    Fluttertoast.showToast(
      msg: "Clock out Failed.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}

Future<List<double>> getCurrentLocation() async {
  try {
    locator.Position position = await locator.Geolocator.getCurrentPosition(
      desiredAccuracy: locator.LocationAccuracy.best,
    );
    return [position.latitude, position.longitude];
  } catch (e) {
    return [0, 0];
  }
}

Future<String> getPosition() async {
  try {
    final data = await getCurrentLocation();
    if (data[0] != 0 && data[1] != 0) {
      final curAddress = await getAddressFromLatLng(data[0], data[1]);
      return curAddress;
    } else
      return "Can't get current position";
  } catch (e) {
    return "Can't get current position";
  }
}

Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark firstPlacemark = placemarks[0];
      //print(firstPlacemark);
      String address =
          '${firstPlacemark.street}, ${firstPlacemark.subLocality}';

      return address;
    } else {
      return 'No address found';
    }
  } catch (e) {
    return 'Error: $e';
  }
}

Future<String> requestLocationPermission(BuildContext context) async {
  final status = await Permission.location.request();
  if (status.isGranted) {
    loc.Location location = loc.Location();
    bool ison = await location.serviceEnabled();
    if (!ison) {
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        return getPosition();
      } else {
        return "GPS not active";
      }
    } else {
      return getPosition();
    }
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    return "GPS not active";
  } else {
    showRetryLocationPermissionDialog(context);
    return "GPS not active";
  }
}

void showRetryLocationPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Permission Required"),
        content: const Text(
            "Please enable location permission to use this feature."),
        actions: [
          TextButton(
            child: const Text("Retry"),
            onPressed: () {
              Navigator.of(context).pop();
              requestLocationPermission(context);
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> openLocationSettings(BuildContext context) async {
  if (await locator.GeolocatorPlatform.instance.isLocationServiceEnabled()) {
    // GPS is already enabled.
    return;
  }

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Enable GPS"),
        content: const Text("Please enable GPS to use this feature."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // ignore: deprecated_member_use
              if (await canLaunch("package:com.android.settings")) {
                // ignore: deprecated_member_use
                await launch("package:com.android.settings");
              }
              Navigator.of(context).pop(true);
            },
            child: const Text("Enable"),
          ),
        ],
      );
    },
  );

  if (result != true) {
    // User canceled the GPS enable request.
    // Handle this as needed.
  }
}

Future<void> checkGPS(BuildContext context, bool mounted) async {
  if (mounted) {
    bool serviceEnabled;

    // Test if location services are enabled.
    serviceEnabled = await locator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      requestLocationPermission(context);
    } else {
      requestLocationPermission(context);
    }
  }
}

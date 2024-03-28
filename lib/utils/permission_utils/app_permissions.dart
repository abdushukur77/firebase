import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    debugPrint("STORAGE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      debugPrint("STORAGE STATUS AFTER ASK:$status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getMediaPermission() async {
    PermissionStatus status = await Permission.accessMediaLocation.status;
    debugPrint("MEDIA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.accessMediaLocation.request();
      debugPrint("MEDIA STATUS AFTER ASK:$status");
    }
  }

  static getAudioPermission() async {
    PermissionStatus status = await Permission.audio.status;
    debugPrint("AUDIO STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.audio.request();
      debugPrint("AUDIO STATUS AFTER ASK:$status");
    }
  }
  static getCalendarPermission() async {
    PermissionStatus status = await Permission.calendarFullAccess.status;
    debugPrint("CALENDAR STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.calendarFullAccess.request();
      debugPrint("CALENDAR STATUS AFTER ASK:$status");
    }
  }
  static getBluetoothPermission() async {
    PermissionStatus status = await Permission.bluetooth.status;
    debugPrint("BLUETOOTH STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetooth.request();
      debugPrint("BLUETOOTH STATUS AFTER ASK:$status");
    }
  }
  static getMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    debugPrint("MICROPHONE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.microphone.request();
      debugPrint("MICROPHONE STATUS AFTER ASK:$status");
    }
  }
  static getPhotoPermission() async {
    PermissionStatus status = await Permission.photos.status;
    debugPrint("PHOTO STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.photos.request();
      debugPrint("PHOTO STATUS AFTER ASK:$status");
    }
  }
  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.sms,
      Permission.mediaLibrary,
      Permission.location,
      Permission.microphone,
      Permission.mediaLibrary,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
        await permissions.request();

    debugPrint(
        "BACKGROUNDREFRESH STATUS AFTER ASK:${somePermissionsResults[Permission.backgroundRefresh]}");
    debugPrint(
        "BLUETOOTH STATUS AFTER ASK:${somePermissionsResults[Permission.bluetoothScan]}");
    debugPrint(
        " IGNORE BATTERY AFTER ASK:${somePermissionsResults[Permission.ignoreBatteryOptimizations]}");
    debugPrint(" NEAR BY WIFI AFTER ASK:${somePermissionsResults[Permission.nearbyWifiDevices]}");
    debugPrint(" MEDIA AFTER ASK:${somePermissionsResults[Permission.mediaLibrary]}");
  }
}

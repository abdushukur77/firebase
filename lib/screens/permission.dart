import 'package:flutter/material.dart';

import '../utils/permission_utils/app_permissions.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("APP PERMISSIONS")),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AppPermissions.getAudioPermission();
              },
              child: const Text("Audio"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getMicrophonePermission();
              },
              child: const Text("Microphone"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getMediaPermission();
              },
              child: const Text("Media"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getBluetoothPermission();
              },
              child: const Text("Calendar"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getPhotoPermission();
              },
              child: const Text("Photo"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getBluetoothPermission();
              },
              child: const Text("Bluetooth"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getCameraPermission();
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getLocationPermission();
              },
              child: const Text("Location"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getPhotoPermission();
              },
              child: const Text("Photo"),
            ),

            TextButton(
              onPressed: () {
                AppPermissions.getContactsPermission();
              },
              child: const Text("Contacts"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getSomePermissions();
              },
              child: const Text("SOME PERMISSIONS"),
            ),
          ],
        ),
      ),
    );
  }
}

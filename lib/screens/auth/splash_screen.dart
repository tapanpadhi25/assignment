import 'dart:io';

import 'package:assignment_application/screens/auth/login_screen.dart';
import 'package:assignment_application/utils/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../project/project_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestAllPermissions();
    Future.delayed(const Duration(seconds: 4)).then((_) {
      _getLoginData();
    });
    super.initState();
  }
  _getLoginData() async{
    bool? isLogin = await SharedPrefHelper.getBool("isLogin");
    if(isLogin == true){
      SharedPrefHelper.setBool("isLogin", true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProjectHomeScreen()));
    }else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
    );
  }
}
Future<bool> requestAllPermissions() async {
  final Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.photos,
    Permission.videos,
    Permission.storage,
    if (Platform.isAndroid) Permission.manageExternalStorage,
  ].request();

  // Check if any permission is permanently denied
  bool allGranted = true;
  for (final entry in statuses.entries) {
    if (entry.value.isPermanentlyDenied) {
      print("Permission permanently denied: ${entry.key}");
      openAppSettings(); // Optionally prompt user to enable in settings
      allGranted = false;
    } else if (!entry.value.isGranted) {
      print("Permission denied: ${entry.key}");
      allGranted = false;
    }
  }

  return allGranted;
}
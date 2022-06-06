import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'modules/auth/auth_screen.dart';
import 'modules/auth/auth_service.dart';
import 'modules/create_update/create_update_binding.dart';
import 'modules/create_update/create_update_screen.dart';
import 'modules/home/home_binding.dart';
import 'modules/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCPuu4cBcAnPG_QWlPTtYCv_HOt48iKYtk',
      appId: '1:823482598636:android:289e530a8486682de191c9',
      messagingSenderId: '448618578101',
      projectId: 'todominimalist-854c5',
      storageBucket: 'todominimalist-854c5.appspot.com',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      getPages: pageList,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const AuthScreen(),
    );
  }

  final pageList = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/create_update',
      page: () => const CreateUpdateScreen(),
      binding: CreateUpdateBinding(),
    ),
  ];
}

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
  }
}

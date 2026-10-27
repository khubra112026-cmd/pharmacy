import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login_screen.dart';
import 'screens/owner_home.dart';
import 'screens/employee_home.dart';
import 'screens/admin_home.dart';
import 'screens/worker_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginScreen(),
      routes: {
        '/owner': (_) => const OwnerHome(),
        '/employee': (_) => const EmployeeHome(),
        '/admin': (_) => const AdminHome(),
        '/worker': (_) => const WorkerHome(),
      },
    );
  }
}
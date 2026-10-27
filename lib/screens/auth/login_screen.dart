import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../owner/owner_home.dart';
import '../employee/employee_home.dart';
import '../admin/admin_home.dart';
import '../admin/worker_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final auth = AuthService();

  void login() async {
    try {
      final result = await auth.login(email.text, password.text);

      if (result['role'] == 'owner') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OwnerHome(
              pharmacyId: result['pharmacyId'],
              pharmacyName: result['pharmacyName'],
            ),
          ),
        );
      } else if (result['role'] == 'employee') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EmployeeHome(
              pharmacyId: result['pharmacyId'],
              pharmacyName: result['pharmacyName'],
            ),
          ),
        );
      } else if (result['role'] == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminHome()),
        );
      } else if (result['role'] == 'worker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WorkerHome()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pharmacy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text('تسجيل الدخول')),
          ],
        ),
      ),
    );
  }
}
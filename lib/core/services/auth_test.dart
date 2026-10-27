import 'package:firebase_auth/firebase_auth.dart';

Future<void> testAuth() async {
  final auth = FirebaseAuth.instance;

  try {
    await auth.createUserWithEmailAndPassword(
      email: 'test@pharmacy.com',
      password: '12345678',
    );
    print('Auth Working ✅');
  } catch (e) {
    print('Auth Error: $e');
  }
}
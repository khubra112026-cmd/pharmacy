import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtpScreen extends StatefulWidget {
  final String pharmacyName;
  final String ownerName;
  final String email;
  final String password;
  final String phone;

  const OtpScreen({
    super.key,
    required this.pharmacyName,
    required this.ownerName,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  late String generatedOtp;

  @override
  void initState() {
    super.initState();
    generatedOtp = (Random().nextInt(9000) + 1000).toString();
    print('OTP (للتجربة فقط): $generatedOtp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التحقق')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('أدخل رمز التحقق المرسل إلى بريدك'),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('تأكيد'),
              onPressed: verifyOtp,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyOtp() async {
    if (otpController.text != generatedOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رمز غير صحيح')),
      );
      return;
    }

    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    final user = await auth.createUserWithEmailAndPassword(
      email: widget.email,
      password: widget.password,
    );

    await firestore.collection('users').doc(user.user!.uid).set({
      'role': 'owner',
      'name': widget.ownerName,
      'email': widget.email,
      'isActive': false,
      'pharmacyId': null,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await firestore.collection('pharmacies_requests').add({
      'pharmacyName': widget.pharmacyName,
      'ownerName': widget.ownerName,
      'email': widget.email,
      'phone': widget.phone,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    await auth.signOut();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال طلبك، سيتم مراجعته خلال 48 ساعة'),
      ),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
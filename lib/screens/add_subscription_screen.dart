import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSubscriptionScreen extends StatefulWidget {
  final String pharmacyId;
  final String pharmacyName;

  const AddSubscriptionScreen({
    super.key,
    required this.pharmacyId,
    required this.pharmacyName,
  });

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  int days = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pharmacyName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('أدخل عدد أيام الاشتراك'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (v) => days = int.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('بدء الاشتراك'),
              onPressed: startSubscription,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startSubscription() async {
    if (days <= 0) return;

    final endDate =
        DateTime.now().add(Duration(days: days));

    await FirebaseFirestore.instance
        .collection('pharmacies')
        .doc(widget.pharmacyId)
        .update({
      'subscriptionEndDate': Timestamp.fromDate(endDate),
      'isActive': true,
    });

    Navigator.pop(context);
  }
}
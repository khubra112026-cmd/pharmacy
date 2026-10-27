import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionControlScreen extends StatefulWidget {
  final String pharmacyId;

  const SubscriptionControlScreen({super.key, required this.pharmacyId});

  @override
  State<SubscriptionControlScreen> createState() =>
      _SubscriptionControlScreenState();
}

class _SubscriptionControlScreenState
    extends State<SubscriptionControlScreen> {
  int days = 30;

  void startSubscription() async {
    final endDate = DateTime.now().add(Duration(days: days));

    await FirebaseFirestore.instance
        .collection('pharmacies')
        .doc(widget.pharmacyId)
        .update({
      'subscriptionEnd': Timestamp.fromDate(endDate),
      'isActive': true,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تفعيل الاشتراك')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الاشتراك')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'عدد الأيام'),
              onChanged: (v) => days = int.tryParse(v) ?? 30,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startSubscription,
              child: const Text('بدء الاشتراك'),
            ),
          ],
        ),
      ),
    );
  }
}
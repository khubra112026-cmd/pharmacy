import 'package:flutter/material.dart';
import '../support/support_list_admin.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم - الأدمن'),
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SupportListAdminScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'واجهة الأدمن\n(إدارة الصيدليات + الاشتراكات + الدعم الفني)',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
  onPressed: () async {
    final pharmacyId = 'pharmacy_id_here';
    final now = DateTime.now();
    final subscriptionDays = 30; // مثال: 30 يوم

    await FirebaseFirestore.instance
        .collection('pharmacies')
        .doc(pharmacyId)
        .update({
      'subscriptionEnd': Timestamp.fromDate(now.add(Duration(days: subscriptionDays))),
      'status': 'active',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم بدء الاشتراك')),
    );
  },
  child: const Text('بدء الاشتراك للصيدلية'),
),
      ),
    );
  }
}
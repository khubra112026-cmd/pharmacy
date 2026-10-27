import 'package:flutter/material.dart';
import '../support/support_chat_screen.dart';
import 'package:flutter/material.dart';
import 'sell_screen.dart';
import 'sales_screen.dart';

class EmployeeHome extends StatelessWidget {
  final String pharmacyId;

  const EmployeeHome({super.key, required this.pharmacyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SalesScreen(pharmacyId: pharmacyId),
      ),
    );
  },
  child: const Text(
    'المبيعات',
    style: TextStyle(color: Colors.white),
  ),
),
        title: const Text('Pharmacy'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SellScreen(pharmacyId: pharmacyId),
                ),
              );
            },
            child: const Text(
              'بيع',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'الصفحة الرئيسية للموظف',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class EmployeeHome extends StatelessWidget {
  final String pharmacyId;
  final String pharmacyName;

  const EmployeeHome({
    super.key,
    required this.pharmacyId,
    required this.pharmacyName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pharmacyName),
        actions: [
          IconButton(
            icon: const Icon(Icons.support_agent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SupportChatScreen(
                    pharmacyId: pharmacyId,
                    pharmacyName: pharmacyName,
                    isAdmin: false,
                  ),
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
          'واجهة الموظف\n(عرض المخزون + البيع + المبيعات)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
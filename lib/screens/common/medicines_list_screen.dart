import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicinesListScreen extends StatelessWidget {
  final String pharmacyId;
  const MedicinesListScreen({super.key, required this.pharmacyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الأدوية')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('medicines')
            .where('pharmacyId', isEqualTo: pharmacyId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['name']),
                subtitle: Text('صناديق: ${doc['boxQty']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.sell),
                  onPressed: () {
                    // البيع في الخطوة التالية
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
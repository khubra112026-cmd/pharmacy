import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  final String pharmacyId;

  const AddProductScreen({super.key, required this.pharmacyId});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة دواء')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'اسم الدواء'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'الكمية'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'السعر'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addProduct,
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addProduct() async {
    final String name = nameController.text;
    final int quantity = int.tryParse(quantityController.text) ?? 0;
    final double price = double.tryParse(priceController.text) ?? 0;

    if (name.isEmpty || quantity <= 0 || price <= 0) return;

    await FirebaseFirestore.instance.collection('products').add({
      'name': name,
      'quantity': quantity,
      'price': price,
      'pharmacyId': widget.pharmacyId,
      'isDeleted': false, // ✅ حقل المحذوفات
      'deletedAt': null,  // ✅ حقل المحذوفات
    });

    Navigator.pop(context);
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMedicineScreen extends StatefulWidget {
  final String pharmacyId;
  const AddMedicineScreen({super.key, required this.pharmacyId});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final name = TextEditingController();
  final boxQty = TextEditingController();
  final boxToStrip = TextEditingController();
  final stripToPill = TextEditingController();
  final priceBox = TextEditingController();
  final priceStrip = TextEditingController();
  final pricePill = TextEditingController();

  void save() async {
    await FirebaseFirestore.instance.collection('medicines').add({
      'pharmacyId': widget.pharmacyId,
      'name': name.text,
      'boxQty': int.parse(boxQty.text),
      'boxToStrip': int.parse(boxToStrip.text),
      'stripToPill': int.parse(stripToPill.text),
      'priceBox': double.parse(priceBox.text),
      'priceStrip': double.parse(priceStrip.text),
      'pricePill': double.parse(pricePill.text),
      'createdAt': Timestamp.now(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة دواء')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: 'اسم الدواء')),
            TextField(controller: boxQty, decoration: const InputDecoration(labelText: 'عدد الصناديق'), keyboardType: TextInputType.number),
            TextField(controller: boxToStrip, decoration: const InputDecoration(labelText: 'عدد الأشرطة في الصندوق'), keyboardType: TextInputType.number),
            TextField(controller: stripToPill, decoration: const InputDecoration(labelText: 'عدد الحبات في الشريط'), keyboardType: TextInputType.number),
            TextField(controller: priceBox, decoration: const InputDecoration(labelText: 'سعر الصندوق'), keyboardType: TextInputType.number),
            TextField(controller: priceStrip, decoration: const InputDecoration(labelText: 'سعر الشريط'), keyboardType: TextInputType.number),
            TextField(controller: pricePill, decoration: const InputDecoration(labelText: 'سعر الحبة'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text('حفظ')),
          ],
        ),
      ),
    );
  }
}
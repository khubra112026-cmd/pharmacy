import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> testFirestore() async {
  await FirebaseFirestore.instance
      .collection('test')
      .doc('check')
      .set({'status': 'working'});
}
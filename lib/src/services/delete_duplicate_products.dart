import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteDuplicateProductsByTitle(String title) async {
  final firestore = FirebaseFirestore.instance;

  final snapshot = await firestore
      .collection('products')
      .where('name', isEqualTo: title)
      .get();

  if (snapshot.docs.length <= 1) {
    print('No duplicates found');
    return;
  }

  // Keep first, delete rest
  for (int i = 1; i < snapshot.docs.length; i++) {
    await snapshot.docs[i].reference.delete();
    print('Deleted duplicate: ${snapshot.docs[i].id}');
  }
}

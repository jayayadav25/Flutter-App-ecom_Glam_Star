import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class JsonImportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //  Import NEW dataset JSON into Firestore
  Future<void> importJsonToFirestore(List<dynamic> jsonList) async {
    debugPrint(" JSON IMPORT STARTED");
    debugPrint(" TOTAL ITEMS = ${jsonList.length}");

    int uploaded = 0;

    for (final item in jsonList) {
      try {
        final productId = item['product_id'].toString();

        debugPrint(" Uploading: ${item['title']}");
        debugPrint("Uploaded image url: ${item['images']}");
        await _firestore
            .collection('products')
            .doc(productId) // IMPORTANT: use product_id as documentId
            .set({
          "product_id": item['product_id'],
          "category": item['category'],
          "sub_category": item['sub_category'],
          "actual_price": item['actual_price'],
          "selling_price": item['selling_price'],
          "discount": item['discount'],
          "average_rating": item['average_rating'],
          "in_stock": item['in_stock'],
          "has_image": item['has_image'],
          "baseColour": item['baseColour'],
          "season": item['season'],
          "year": item['year'],
          "usage": item['usage'],
          "title": item['title'],
          "slug": item['slug'],
          "description": item['description'],
          "images": item['images'],
          "createdAt": FieldValue.serverTimestamp(),
        });

        uploaded++;
        print(" Uploading: ${item['title']}");
        print("Images = ${item['images']}");
        print(" Product ID = ${item['product_id']}");

      } catch (e) {
        debugPrint(" Failed to upload product → $e");
      }
    }

    debugPrint("JSON IMPORT COMPLETED");
    debugPrint(" TOTAL UPLOADED = $uploaded");
  }
}

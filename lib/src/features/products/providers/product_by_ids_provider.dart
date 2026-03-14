import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/light_product_model.dart';

final productsByIdsProvider =
FutureProvider.family<List<LightProductModel>, List<int>>(
        (ref, ids) async {
      debugPrint("Resolving Product Ids: $ids");

      final snap = await FirebaseFirestore.instance
          .collection('products_light')
          .where('product_id', whereIn: ids.take(10).toList())
          .get();

      debugPrint("Firestore products found ${snap.docs.length}");

      return snap.docs
          .map((d) => LightProductModel.fromJson(d.data()))
          .toList();
    });


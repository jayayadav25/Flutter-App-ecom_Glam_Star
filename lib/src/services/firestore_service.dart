import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  // Add document
  Future<String> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    final docRef = await _firestore.collection(collectionPath).add(data);
    return docRef.id;
  }

  // Set document with custom ID
  Future<void> setDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).set(data);
  }

  // Update document
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  // Delete document
  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }

  // Fetch single document (one-time read)
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String docId,
  }) async {
    return _firestore.collection(collectionPath).doc(docId).get();
  }

  // Stream a single document (real-time updates)
  Stream<DocumentSnapshot<Map<String, dynamic>>> watchDocument({
    required String collectionPath,
    required String docId,
  }) {
    return _firestore.collection(collectionPath).doc(docId).snapshots();
  }

  // Stream collection
  Stream<List<Map<String, dynamic>>> collectionStream({
    required String collectionPath,
    Query Function(Query query)? queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(collectionPath).withConverter<Map<String, dynamic>>(
      fromFirestore: (snap, _) => snap.data() ?? <String, dynamic>{},
      toFirestore: (data, _) => data,
    );

    if (queryBuilder != null) query = queryBuilder(query) as Query<Map<String, dynamic>>;

    return query.snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList(),
    );
  }
}

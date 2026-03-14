import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebugProductsScreen extends StatelessWidget {
  const DebugProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug Products")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          debugPrint("🔥 FIRESTORE DOC COUNT = ${docs.length}");

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final d = docs[i].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(d['title'] ?? 'NO TITLE'),
                subtitle: Text(
                  (d['images'] is List && d['images'].isNotEmpty)
                      ? d['images'][0]
                      : 'NO IMAGE',
                ),
              );
            },
          );
        },
      ),
    );
  }
}

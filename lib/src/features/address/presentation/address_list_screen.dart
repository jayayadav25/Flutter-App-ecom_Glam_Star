import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../provider/address_provider.dart';

class AddressListScreen extends ConsumerWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsync = ref.watch(addressProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Select Address")),
      body: addressAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (addresses) {
          if (addresses.isEmpty) {
            return Center(
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Add Address"),
                onPressed: () => context.push('/add-address'),
              ),
            );
          }

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (_, i) {
              final a = addresses[i];

              return ListTile(
                title: Text(a.name),
                subtitle: Text("${a.house}, ${a.city}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final uid =
                        FirebaseAuth.instance.currentUser!.uid;

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('addresses')
                        .doc(a.id)
                        .delete();

                    ref.invalidate(addressProvider);
                  },
                ),
                onTap: () {
                  ref.read(selectedAddressProvider.notifier).state = a;
                  context.pop();
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/address_provider.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  const AddAddressScreen({super.key});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final pinCtrl = TextEditingController();
  final houseCtrl = TextEditingController();
  final cityCtrl = TextEditingController();

  bool isDefault = true;
  bool loading = false;

  Future<void> saveAddress() async {
    setState(() => loading = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final addressRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('addresses');

    await addressRef.add({
      'name': nameCtrl.text.trim(),
      'phone': phoneCtrl.text.trim(),
      'pincode': pinCtrl.text.trim(),
      'house': houseCtrl.text.trim(),
      'city': cityCtrl.text.trim(),
      'isDefault': isDefault,
      'createdAt': FieldValue.serverTimestamp(),
    });

    ref.invalidate(addressProvider);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Address")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field(nameCtrl, "Full Name"),
            _field(phoneCtrl, "Phone"),
            _field(pinCtrl, "Pincode"),
            _field(houseCtrl, "House / Flat / Office"),
            _field(cityCtrl, "City"),

            SwitchListTile(
              title: const Text("Make this default address"),
              value: isDefault,
              onChanged: (v) => setState(() => isDefault = v),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : saveAddress,
                child: const Text("Ship to this address"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_mastery_app/src/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/address_provider.dart';
import '../widgets/address_card.dart';
import '../widgets/address_empty_state.dart';
import '../widgets/address_loading_shimmer.dart';

class AddressListScreen extends ConsumerWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final addressAsync = ref.watch(addressProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        title: const Text("My Addresses",),),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlack,
        foregroundColor: AppColors.whiteText,
        onPressed: () {
          context.push('/addresses/add');
        },
        label: const Text("Add Address"),
        icon: const Icon(Icons.add),
      ),

      body: addressAsync.when(
        loading: () => const AddressLoadingShimmer(),

        error: (e, _) => Center(child: Text('$e')),
        data: (addresses) {
          if (addresses.isEmpty) {
            return AddressEmptyState(
              onAdd: () {
                context.push('/addresses/add');
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: addresses.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, index) {
              final address = addresses[index];
              return AddressCard(
                address: address,

                onTap: () {
                  ref.read(selectedAddressProvider.notifier,).state = address;
                  context.pop();
                },
                onEdit: () {
                  context.push('/addresses/edit', extra: address,);
                },

                onDelete: () async {
                  final uid = ref.read(firebaseAuthProvider).currentUser!.uid;
                  await ref.read(addressControllerProvider.notifier,)
                      .deleteAddress(uid: uid, addressId: address.id,);
                },
                onSetDefault: () async {
                  final uid = ref.read(firebaseAuthProvider).currentUser!.uid;
                  await ref.read(addressControllerProvider.notifier,)
                      .setDefaultAddress(uid: uid, addressId: address.id,);
                },
              );
            },
          );
        },
      ),
    );
  }
}
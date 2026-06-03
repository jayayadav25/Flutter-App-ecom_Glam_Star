import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/address_model.dart';
import '../provider/address_provider.dart';
import '../widgets/address_form.dart';


class AddEditAddressScreen extends ConsumerWidget {
  final AddressModel? address;

  const AddEditAddressScreen({super.key, this.address,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final uid = ref.read(firebaseAuthProvider).currentUser!.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor:AppColors.cardColor,
        title: Text(address == null ? "Add Address" : "Edit Address",),),

      body: AddressForm(
        address: address,
        onSubmit: (
            fullName,
            phone,
            address1,
            address2,
            city,
            state,
            zipCode,
            type,
            isDefault,
            ) async {
          final model = AddressModel(
            id: address?.id ?? const Uuid().v4(),
            fullName: fullName,
            phone: phone,
            addressLine1: address1,
            addressLine2: address2,
            landmark: '',
            city: city,
            state: state,
            country: 'India',
            zipCode: zipCode,
            addressType: type,
            isDefault: isDefault,
            latitude: null,
            longitude: null,
            createdAt: DateTime.now(),);

          if (address == null) {
            await ref.read(addressControllerProvider.notifier,)
                .addAddress(uid: uid, address: model,);
          } else {
            await ref.read(addressControllerProvider.notifier,)
                .updateAddress(uid: uid, address: model,);
          }

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
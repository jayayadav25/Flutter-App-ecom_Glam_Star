import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/address_model.dart';
import '../provider/address_provider.dart';

class AddressController extends AsyncNotifier<void> {

  @override
  Future<void> build() async {}

  Future<void> addAddress({
    required String uid,
    required AddressModel address,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(addressRemoteRepoProvider).addAddress(
        uid: uid, address: address,
      );
      ref.invalidate(addressProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> setDefaultAddress({required String uid, required String addressId,}) async {
    try {
      await ref.read(addressRemoteRepoProvider).setDefaultAddress(
        uid: uid, addressId: addressId,
      );
      ref.invalidate(addressProvider);
    } catch (_) {}
  }

  Future<void> updateAddress({
    required String uid,
    required AddressModel address,
  }) async {
    state = const AsyncLoading();
    try {
      await ref.read(addressRemoteRepoProvider).updateAddress(
        uid: uid, address: address,
      );
      ref.invalidate(addressProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteAddress({
    required String uid,
    required String addressId,
  }) async {

    try {
      await ref.read(addressRemoteRepoProvider).deleteAddress(
        uid: uid, addressId: addressId,
      );
      ref.invalidate(addressProvider);
    } catch (_) {}
  }
}
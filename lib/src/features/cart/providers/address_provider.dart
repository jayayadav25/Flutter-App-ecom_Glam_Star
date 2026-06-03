
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Address {
  final String name;
  final String addressLine;

  Address(this.name, this.addressLine);
}

final selectedAddressProvider =
StateNotifierProvider<AddressNotifier, Address?>(
      (ref) => AddressNotifier(),
);

class AddressNotifier extends StateNotifier<Address?> {
  AddressNotifier() : super(
    Address("Neha Yadav", "Bangalore, Karnataka - 560001"),
  );

  void change(Address newAddress) {
    state = newAddress;
  }
}

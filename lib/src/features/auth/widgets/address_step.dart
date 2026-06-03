import 'package:flutter/material.dart';
import '../../../common/styles/app_input_decoration.dart';

class AddressStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController addressCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController stateCtrl;
  final TextEditingController pincodeCtrl;

  const AddressStep({
    super.key,
    required this.formKey,
    required this.addressCtrl,
    required this.cityCtrl,
    required this.stateCtrl,
    required this.pincodeCtrl,
  });

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: addressCtrl,
            maxLines: 3,
            decoration: AppInputDecoration.auth(
              hintText: 'Address',
              prefixIcon: Icons.location_on_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter address';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          TextFormField(
            controller: cityCtrl,
            decoration: AppInputDecoration.auth(
              hintText: 'City',
              prefixIcon: Icons.location_city_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter city';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          TextFormField(
            controller: stateCtrl,
            decoration: AppInputDecoration.auth(
              hintText: 'State',
              prefixIcon: Icons.map_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter state';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: pincodeCtrl,
            keyboardType: TextInputType.number,
            decoration: AppInputDecoration.auth(
              hintText: 'Pincode',
              prefixIcon: Icons.pin_drop_outlined,
            ),

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter pincode';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}


import 'package:firebase_mastery_app/src/common/styles/app_button_styles.dart';
import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/address_model.dart';
import '../utils/address_constant.dart';
import '../utils/address_validator.dart';

class AddressForm extends StatefulWidget {
  final AddressModel? address;

  final Function(
      String fullName,
      String phone,
      String address1,
      String address2,
      String city,
      String state,
      String zipCode,
      String type,
      bool isDefault,
      ) onSubmit;

  const AddressForm({super.key,
    this.address, required this.onSubmit,});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {

  final formKey = GlobalKey<FormState>();
  late TextEditingController fullNameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController address1Ctrl;
  late TextEditingController address2Ctrl;
  late TextEditingController cityCtrl;
  late TextEditingController stateCtrl;
  late TextEditingController zipCtrl;
  bool isDefault = true;
  String addressType = "Home";

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    fullNameCtrl = TextEditingController(text: a?.fullName ?? '',);
    phoneCtrl = TextEditingController(text: a?.phone ?? '',);
    address1Ctrl = TextEditingController(text: a?.addressLine1 ?? '',);
    address2Ctrl = TextEditingController(text: a?.addressLine2 ?? '',
    );

    cityCtrl = TextEditingController(text: a?.city ?? '',);
    stateCtrl = TextEditingController(text: a?.state ?? '',);
    zipCtrl = TextEditingController(text: a?.zipCode ?? '',);
    isDefault = a?.isDefault ?? true;
    addressType = a?.addressType ?? "Home";
  }

  @override
  void dispose() {
    fullNameCtrl.dispose();
    phoneCtrl.dispose();
    address1Ctrl.dispose();
    address2Ctrl.dispose();
    cityCtrl.dispose();
    stateCtrl.dispose();
    zipCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _field(fullNameCtrl, "Full Name",
              validator: AddressValidator.validateName,),
            _field(phoneCtrl, "Phone Number",
              validator: AddressValidator.validatePhone,),
            _field(address1Ctrl, "Address Line 1",
              validator: AddressValidator.validateAddress,),
            _field(address2Ctrl, "Address Line 2",
              //validator: AddressValidator.validateAddress,
            ),
            _field(cityCtrl, "City",
              validator: AddressValidator.validateCity,),
            _field(stateCtrl, "State",
              validator: AddressValidator.validateState,),
            _field(zipCtrl, "Zip Code",
              validator: AddressValidator.validateZipcode,
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 12,
              children: AddressConstants.addressTypes.map((e) {
                final isSelected = addressType == e;
                return ChoiceChip(
                  label: Text(e),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      addressType = e;
                    });
                  },
                  selectedColor: AppColors.primaryBlack,
                  backgroundColor: Colors.white,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primaryBlack,
                    fontWeight: FontWeight.w600,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),

                    side: BorderSide(
                      color: isSelected ? AppColors.primaryBlack : Colors.grey.shade300,
                    ),
                  ),

                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10,),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: isDefault,
              onChanged: (v) {
                setState(() {
                  isDefault = v;
                });
              },
              activeColor: Colors.white,
              activeTrackColor: Colors.black,

              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.white,

              title: const Text("Default Address",),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 56,

              child: ElevatedButton(
                style: AppButtonStyles.primaryButton,
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  widget.onSubmit(
                    fullNameCtrl.text,
                    phoneCtrl.text,
                    address1Ctrl.text,
                    address2Ctrl.text,
                    cityCtrl.text,
                    stateCtrl.text,
                    zipCtrl.text,
                    addressType,
                    isDefault,
                  );
                },

                child: const Text(
                  "Save Address",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
      TextEditingController controller,
      String hint, { String? Function(String?)?validator,}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,),

      child:TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.8,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.red, width: 1.8,
            ),
          ),
        ),
      )
    );
  }
}
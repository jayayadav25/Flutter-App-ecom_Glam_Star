import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';
import '../../profile/providers/profile_providers.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserModel user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    //phoneController = TextEditingController(text: widget.user.phone ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              CustomTextField(
                controller: nameController,
                hintText: "Full Name",
                icon: Icons.person,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: phoneController,
                hintText: "Phone Number",
                icon: Icons.phone,
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: "Save Changes",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedData = {
                      'name': nameController.text.trim(),
                      'phone': phoneController.text.trim(),
                    };

                    await ref.read(updateProfileProvider)
                        .updateProfile(
                      uid: widget.user.uid,
                      data: updatedData,
                    );

                    if (context.mounted) context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

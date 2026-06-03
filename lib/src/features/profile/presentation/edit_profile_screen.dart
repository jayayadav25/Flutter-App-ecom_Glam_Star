import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/user_model.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_avatar_section.dart';
import '../widgets/profile_gender_selector.dart';
import '../widgets/profile_input_field.dart';
import '../widgets/profile_section_tile.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user,});

  @override
  ConsumerState<EditProfileScreen>createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {

  final formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController bioCtrl;
  String gender = "Male";

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    nameCtrl = TextEditingController(
          text: user.name,
        );
    emailCtrl = TextEditingController(
          text: user.email,
        );

    phoneCtrl = TextEditingController(
          text: user.phone ?? '',
        );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(profileControllerProvider,).isLoading;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
        Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Center(
                  child: ProfileAvatarSection(
                    user: widget.user,
                  ),
                ),

                const SizedBox(height: 32),
                const ProfileSectionTitle(
                  title: "Personal Information",
                ),

                const SizedBox(height: 18),
                ProfileInputField(
                  controller: nameCtrl,
                  hint: "Full Name",
                  icon: Icons.person,
                ),

                const SizedBox(height: 18),

                ProfileInputField(
                  controller: emailCtrl,
                  hint: "Email Address",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                ProfileInputField(
                  controller: phoneCtrl,
                  hint: "Phone Number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 28),

                const ProfileSectionTitle(
                  title: "Additional Information",
                ),

                const SizedBox(height: 18),

                ProfileGenderSelector(
                  selected: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),

                const SizedBox(height: 18),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: loading ? null : () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      await ref.read(profileControllerProvider.notifier,
                      ).updateProfile(
                        uid: widget.user.uid,
                        data: {
                          'name': nameCtrl.text.trim(),
                          'email': emailCtrl.text.trim(),
                          'phone': phoneCtrl.text.trim(),
                          'gender': gender,
                        },
                      );

                      if (context.mounted) {
                        Navigator.pop(context,);
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20,),
                      ),
                    ),

                    child: loading ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    ) : const Text(
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
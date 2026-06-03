import 'package:firebase_mastery_app/src/common/styles/app_button_styles.dart';
import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/user_model.dart';
import '../providers/profile_providers.dart';
import 'premium_badge.dart';

class ProfileHeader extends ConsumerWidget {
  final UserModel user;
  final VoidCallback onEdit;

  const ProfileHeader({super.key, required this.user, required this.onEdit,});

  @override
  Widget build(BuildContext context, WidgetRef ref,){
    return Container(
      padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: user.profileImage != null ? NetworkImage(
                  user.profileImage!,
                ) : null,

                child: user.profileImage == null ? const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                )
                    : null,
              ),

              Positioned(
                bottom: 0,
                right: 5,
                child: InkWell(
                  onTap: () async {
                    await ref.read(profileControllerProvider.notifier,)
                        .updateProfileImage( uid: user.uid,
                    );
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlack,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, width: 2,
                      ),
                    ),

                    child: const Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Text(user.name,
            style: AppTextStyles.titleLarge
          ),

          const SizedBox(height: 6),

          // Text(user.email,
          //   style: const TextStyle(
          //     color: Colors.black,
          //   ),
          // ),

         // const SizedBox(height: 10),

          if (user.isPremium)
            const PremiumBadge(),
          ElevatedButton(
            style: AppButtonStyles.primaryButton,
            onPressed: onEdit,
            child: Text('Edit Profile',
            style:AppTextStyles.caption,),
          ),
        ],
      ),
    );
  }
}

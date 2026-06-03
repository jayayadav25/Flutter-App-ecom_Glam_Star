import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/user_model.dart';
import '../providers/profile_providers.dart';

class ProfileAvatarSection extends ConsumerWidget {
  final UserModel user;

  const ProfileAvatarSection({super.key, required this.user,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 56,
          backgroundColor:
          Colors.grey.shade200,
          backgroundImage: user.profileImage != null ? NetworkImage(user.profileImage!,) : null,
          child: user.profileImage == null ? const Icon(
            Icons.person,
            size: 55,
            color: Colors.grey,
          ) : null,
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () async {
              await ref.read(profileControllerProvider.notifier,
              ).updateProfileImage(
                uid: user.uid,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlack,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),

              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
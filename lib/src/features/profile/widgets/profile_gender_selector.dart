import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileGenderSelector extends ConsumerWidget {

  final String selected;

  final ValueChanged<String>
  onChanged;

  const ProfileGenderSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final genders = [
      "Male",
      "Female",
      "Other",
    ];

    return Wrap(
      spacing: 12,
      children: genders.map((e) {
        final isSelected = selected == e;
        return ChoiceChip(
          label: Text(e),
          selected: isSelected,
          onSelected: (_) {
            onChanged(e);
          },
          selectedColor: Colors.black,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),

          checkmarkColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14,),
          ),
        );
      }).toList(),
    );
  }
}
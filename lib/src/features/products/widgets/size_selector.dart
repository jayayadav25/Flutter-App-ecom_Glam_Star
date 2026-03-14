import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String selected = "M";
  final sizes = ["S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: sizes.map((s) {
        final active = s == selected;
        return GestureDetector(
          onTap: () => setState(() => selected = s),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: active ? Colors.black : Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              s,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: active ? Colors.black : Colors.grey,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

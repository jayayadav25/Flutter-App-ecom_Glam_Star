import 'package:flutter/material.dart';

class RemoveCartButton extends StatelessWidget {
  final VoidCallback onRemove;

  const RemoveCartButton({
    super.key,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.close,
          size: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
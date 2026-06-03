import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _button(
          icon: Icons.remove,
          onTap: onDecrement,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14,),
          child: Text('$quantity',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        _button(
          icon: Icons.add,
          onTap: onIncrement,
        ),
      ],
    );
  }

  Widget _button({
    required IconData icon,
    required VoidCallback onTap,
  }) {

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
        ),
      ),
    );
  }
}
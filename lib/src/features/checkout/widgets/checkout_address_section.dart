import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final String name;
  final String address;

  const AddressSection({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            child: Icon(Icons.location_on),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(address),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
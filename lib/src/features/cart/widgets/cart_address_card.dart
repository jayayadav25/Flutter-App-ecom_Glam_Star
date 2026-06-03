import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Jaipur, Rajasthan - 302001',
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('CHANGE'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ReturnPolicySection extends StatelessWidget {
  const ReturnPolicySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Return & Exchange",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text("• 7 days return available"),
          Text("• Exchange within 10 days"),
          Text("• No return on innerwear & cosmetics"),
        ],
      ),
    );
  }
}

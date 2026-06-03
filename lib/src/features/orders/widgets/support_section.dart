import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportSection extends ConsumerWidget {

  const SupportSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Need Help?',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.chat_outlined,
            ),
            title: const Text('Chat Support',),
            trailing: const Icon(Icons.keyboard_arrow_right,),
            onTap: () {},
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.call_outlined,
            ),
            title: const Text('Call Support',),
            trailing:
            const Icon(Icons.keyboard_arrow_right,),
            onTap: () {},
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.help_outline,),
            title: const Text('FAQ',),
            trailing: const Icon(Icons.keyboard_arrow_right,),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
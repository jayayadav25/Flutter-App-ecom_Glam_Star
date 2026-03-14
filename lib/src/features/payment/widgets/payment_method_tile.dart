import 'package:flutter/material.dart';

class PaymentMethodTile extends StatefulWidget {
  final String title;
  final Widget child;
  final IconData icon;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.child,
    required this.icon,
  });

  @override
  State<PaymentMethodTile> createState() => _PaymentMethodTileState();
}

class _PaymentMethodTileState extends State<PaymentMethodTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(widget.icon, size: 26),
            title: Text(widget.title),
            trailing: Icon(
              expanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onTap: () => setState(() => expanded = !expanded),
          ),
          if (expanded) Padding(
            padding: const EdgeInsets.all(12),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

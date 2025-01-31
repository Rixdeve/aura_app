import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  final String status;
  final VoidCallback onTap;

  const ReportButton({super.key, required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (status != "Delivered") {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
      ),
      child: const Text("Report"),
    );
  }
}

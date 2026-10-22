import 'package:flutter/material.dart';

import '../core/app_layout.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.arrow_forward_rounded,
    this.isLoading = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading && !MediaQuery.disableAnimationsOf(context)
          ? SizedBox.square(
              dimension: AppLayout.sp(context, 20, min: 18, max: 24),
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(isLoading ? Icons.hourglass_top_rounded : icon),
      label: Text(
        label,
        style: TextStyle(
          fontSize: AppLayout.sp(context, 16, min: 15, max: 20),
          fontWeight: FontWeight.w800,
        ),
      ),
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(
          AppLayout.gap(context, 6.6, min: 52, max: 66),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppLayout.sp(context, 18, min: 16, max: 22),
          ),
        ),
      ),
    ),
  );
}

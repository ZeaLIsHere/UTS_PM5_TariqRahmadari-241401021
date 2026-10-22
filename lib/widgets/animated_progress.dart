import 'package:flutter/material.dart';

import '../core/app_layout.dart';
import '../core/app_motion.dart';

class AnimatedProgress extends StatelessWidget {
  const AnimatedProgress({super.key, required this.value, required this.label});

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    value: '${(value * 100).round()}%',
    child: ExcludeSemantics(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: value),
        duration: AppMotion.duration(context, milliseconds: 320),
        curve: Curves.easeOutCubic,
        builder: (context, progress, _) => LinearProgressIndicator(
          value: progress,
          minHeight: AppLayout.sp(context, 8, min: 7, max: 11),
          borderRadius: BorderRadius.circular(
            AppLayout.sp(context, 10, min: 8, max: 14),
          ),
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

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
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest,
        ),
      ),
    ),
  );
}

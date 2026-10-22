import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_layout.dart';
import '../core/app_motion.dart';

/// A single seal arrival marks completion without delaying the score or actions.
class ResultBadge extends StatelessWidget {
  const ResultBadge({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: .85, end: 1),
        duration: AppMotion.duration(context, milliseconds: 520),
        curve: Curves.easeOutCubic,
        builder: (context, scale, child) => Transform.scale(
          scale: MediaQuery.disableAnimationsOf(context) ? 1 : scale,
          child: child,
        ),
        child: SvgPicture.asset(
          'assets/svg/result_seal.svg',
          height: height.clamp(
            AppLayout.sp(context, 96, min: 80, max: 210),
            AppLayout.vh(context, 26, min: 80, max: 230),
          ),
          semanticsLabel: 'Lencana hasil kuis',
        ),
      );
}

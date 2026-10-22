import 'package:flutter/material.dart';

import '../core/app_layout.dart';
import '../core/app_motion.dart';

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    super.key,
    required this.label,
    required this.text,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = AppLayout.sp(context, 18, min: 16, max: 22);
    final avatarRadius = AppLayout.sp(context, 19, min: 17, max: 23);
    return Semantics(
      selected: selected,
      button: true,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: AppLayout.sp(context, 12, min: 9, max: 16),
        ),
        child: Material(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radius),
            child: AnimatedContainer(
              duration: AppMotion.duration(context),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.all(
                AppLayout.sp(context, 16, min: 13, max: 21),
              ),
              decoration: BoxDecoration(
                color: selected
                    ? scheme.primary.withValues(alpha: .10)
                    : Colors.transparent,
                border: Border.all(
                  color: selected ? scheme.primary : scheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: selected
                        ? scheme.primary
                        : scheme.surfaceContainerHighest,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: selected ? scheme.onPrimary : scheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppLayout.sp(context, 16, min: 12, max: 22),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: AppLayout.sp(
                          context,
                          16,
                          min: 15,
                          max: 19,
                        ),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppLayout.sp(context, 8, min: 6, max: 11),
                  ),
                  SizedBox(
                    width: AppLayout.sp(context, 24, min: 22, max: 28),
                    child: AnimatedOpacity(
                      opacity: selected ? 1 : 0,
                      duration: AppMotion.duration(context),
                      child: selected
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: scheme.primary,
                              size: AppLayout.sp(context, 24, min: 22, max: 28),
                            )
                          : SizedBox(
                              height: AppLayout.sp(
                                context,
                                24,
                                min: 22,
                                max: 28,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../core/app_theme.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: selected
            ? AppTheme.coral.withValues(alpha: .12)
            : scheme.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? AppTheme.coral : scheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: selected
                      ? AppTheme.coral
                      : scheme.surfaceContainerHighest,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected ? Colors.white : scheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle_rounded, color: AppTheme.coral),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, this.trailing});
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        SvgPicture.asset(
          'assets/svg/mascot_kitsune.svg',
          width: 42,
          height: 42,
          semanticsLabel: 'Maskot kitsune',
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'YŌKAI QUEST',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge?.copyWith(letterSpacing: .6),
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}

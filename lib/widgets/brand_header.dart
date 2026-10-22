import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_layout.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, this.trailing});
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoSize = AppLayout.sp(context, 42, min: 34, max: 50);
    return Row(
      children: [
        SvgPicture.asset(
          'assets/svg/mascot_kitsune.svg',
          width: logoSize,
          height: logoSize,
          semanticsLabel: 'Maskot kitsune',
        ),
        SizedBox(width: AppLayout.sp(context, 10, min: 8, max: 14)),
        Expanded(
          child: Text(
            'YŌKAI QUEST',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge?.copyWith(
              letterSpacing: AppLayout.sp(context, .6),
            ),
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: AppLayout.sp(context, 8, min: 6, max: 12)),
          trailing!,
        ],
      ],
    );
  }
}

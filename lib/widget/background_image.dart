

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.isLandscape,
  });

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sh.roundToDouble(),
      height: 1.sh.roundToDouble(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isLandscape
                ? 'assets/images/name_logo.png'
                : 'assets/images/portrait_background.png',
          ),
          fit: isLandscape ? BoxFit.fitHeight : BoxFit.cover,
          alignment: isLandscape
              ? Alignment.center // landscape হলে মাঝখানে আসবে
              : Alignment.topCenter,// image পুরো screen কভার করবে
        ),
      ),
    );
  }
}
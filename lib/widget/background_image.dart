

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
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isLandscape
                ? 'assets/images/landscape_background.png'
                : 'assets/images/portrait_background.png',
          ),
        ),
      ),
    );
  }
}
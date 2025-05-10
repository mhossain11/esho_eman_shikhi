import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildGridItem extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;
  final bool isLandscape;

  const BuildGridItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(isLandscape ? 4.w : 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: isLandscape ? 30.w : 40.w,
                height: isLandscape ? 25.h : 30.h,
              ),
              SizedBox(height: isLandscape ? 4.h : 8.h),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:isLandscape ?9.sp: 14.sp,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

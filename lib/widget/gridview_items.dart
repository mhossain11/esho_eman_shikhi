

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controller/data_controller.dart';
import '../screen/bookmark_screen.dart';
import '../screen/communication_screen.dart';
import '../screen/showpdf_screen.dart';
import 'buildgriditem.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({
    super.key,
    required this.isLandscape,
  });

  final bool isLandscape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 10.w : 30.w,
        vertical: isLandscape ? 10.h : 32.h,
      ),
      child: SizedBox(
        width: isLandscape ? 0.5.sw : 0.9.sw,
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 5.h,
          children: [
            // 1st button
            BuildGridItem(
              isLandscape: isLandscape,
              icon: 'assets/icon/book.png',
              label: 'বই পড়ুন',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ShowPdfScreen(),
                  ),
                );
              },
            ),

            // 2nd button (বুকমার্ক)
            BuildGridItem(
              isLandscape: isLandscape,
              icon: 'assets/icon/bookmark.png',
              label: 'বুকমার্ক',
              onTap: () async {
                final controller = Provider.of<DataController>(context, listen: false);
                await controller.loadBookmarks();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookmarkScreen( bookmarks: controller.bookmarks,),
                  ),
                );
              },
            ),

            // 3rd button
            BuildGridItem(
              isLandscape: isLandscape,
              icon: 'assets/icon/dots.png',
              label: 'যোগাযোগ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CommunicationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
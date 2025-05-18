import 'package:esho_eman_shikhi/model/menu_item_model.dart';
import 'package:esho_eman_shikhi/screen/questionandansswerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/communication_screen.dart';
import '../screen/showpdf_screen.dart';
import '../screen/bookmark_screen.dart';
import '../widget/buildgriditem.dart';
import '../widget/menuitem.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});



  @override
  Widget build(BuildContext context) {
    PopupMenuItem<MenuItemModel> buildItem(MenuItemModel item) {
      return PopupMenuItem<MenuItemModel>(
        value: item,
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionAndAnswerScreen()));
          },
          child: Row(
            children: [
              Image.asset(
                item.iconPath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Text(item.text),
            ],
          ),
        ),
      );
    }
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
         /* PopupMenuButton<MenuItemModel>(itemBuilder: (context)=>[
            ...MenuItem.itemList.map((item) => buildItem(item)).toList(),
          ])*/
        ],
      ),
      body: Stack(
        children: [
          // Background
          Container(
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
          ),

          // Grid items
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
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
                    BuildGridItem(
                      isLandscape: isLandscape,
                      icon: 'assets/icon/bookmark.png',
                      label: 'বুকমার্ক',
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final bookmarks = prefs.getStringList('bookmarkedPages') ?? [];
                        final bookmarkPages = bookmarks.map((e) => int.tryParse(e) ?? 0).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookmarkScreen(bookmarkedPages: bookmarkPages),
                          ),
                        );
                      },
                    ),
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
            ),
          ),
        ],
      ),
    );
  }
}

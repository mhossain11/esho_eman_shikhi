import 'package:esho_eman_shikhi/screen/showpdf_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookmark_screen.dart';



/*class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background Image
              SizedBox(
                width: width,
                height: height,
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
          
              // Button Grid Positioned at Bottom
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: width * 0.9,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildGridItem(
                          context,
                          icon: 'assets/icon/book.png',
                          label: 'বই পড়ুন',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ShowPdfScreen(),
                              ),
                            );
                          },
                        ),
                        _buildGridItem(context,
                            icon: 'assets/icon/star.png',
                            label: 'রেটিং দিন',
                             onTap:(){}
                        ),
                        _buildGridItem(context,
                            icon: 'assets/icon/dots.png',
                            label: 'যোগাযোগ',
                            onTap: (){}
          
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context,
      {required String icon, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, width: 40, height: 30),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:isLandscape? AssetImage('assets/images/landscape_background.png'):
                  AssetImage('assets/images/portrait_background.png'),
                ),
              ),
            ),
            /*Positioned.fill(
              child: Image.asset(
                isLandscape
                    ? 'assets/images/landscape_background.png'
                    : 'assets/images/portrait_background.png',
                fit: BoxFit.cover,
              ),
            ),*/

            // Main content
            Align(
              alignment: isLandscape ? Alignment.bottomCenter : Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 32),
                child: SizedBox(
                  width: isLandscape ? size.width * 0.5 : size.width * 0.9,
                  child: GridView.count(
                    padding:isLandscape ? EdgeInsets.only(left: 35):EdgeInsets.only(left: 0),
                    shrinkWrap: true,
                    crossAxisCount: isLandscape ? 3 : 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildGridItem(
                        context,
                        isLandscape:isLandscape,
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
                      _buildGridItem(
                        context,
                        isLandscape:isLandscape,
                        icon: 'assets/icon/bookmark.png',
                        label: 'বুকমার্ক',
                        onTap: () async{
                          final prefs = await SharedPreferences.getInstance();
                          final bookmarks = prefs.getStringList('bookmarkedPages') ?? [];
                          final bookmarkPages = bookmarks.map((e) => int.parse(e)).toList();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookmarkScreen(bookmarkedPages: bookmarkPages),
                            ),
                          );
                        },
                      ),
                      _buildGridItem(
                        context,
                        isLandscape:isLandscape,
                        icon: 'assets/icon/dots.png',
                        label: 'যোগাযোগ',
                        onTap: () {
                          // TODO: Implement contact functionality
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context,
      {required String icon,
        required String label,
        VoidCallback? onTap,
        required bool isLandscape,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding:isLandscape ? const EdgeInsets.all(2.0):const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLandscape ?Image.asset(icon, width: 20, height: 20):
              Image.asset(icon, width: 40, height: 30),
              isLandscape ? const SizedBox(height: 3):const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


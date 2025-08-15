import 'dart:convert';

import 'package:esho_eman_shikhi/model/save_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'showpdf_screen.dart';

class BookmarkScreen extends StatefulWidget {
  final List<int> bookmarkedPages;

  const BookmarkScreen({super.key, required this.bookmarkedPages});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late List<int> _bookmarks;


  @override
  void initState() {
    super.initState();
    _bookmarks = List.from(widget.bookmarkedPages); // Copy of original
  }

  Future<void> _deleteBookmark(int page) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList('bookmarkedPages') ?? [];

    // Remove the page from the SharedPreferences list
    stringList.remove(page.toString());
    await prefs.setStringList('bookmarkedPages', stringList);

    // Update the local state list
    setState(() {
      _bookmarks.remove(page);
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: const Text('বুকমার্ক তালিকা',style: TextStyle(fontWeight:FontWeight.bold ),),
          centerTitle: true,
      ),
      body: _bookmarks.isEmpty ?
      Center(child: Text('বইয়ের পৃষ্ঠা বুকমার্ক করা নেই।',
        style: TextStyle(fontSize: 20.sp),)):
      /*ListView.builder(
        itemCount: _bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = _bookmarks[index];
          int pageNum = int.tryParse(bookmark) ?? 0;

          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            child: ListTile(
              title: Text(
                "বইয়ের পৃষ্ঠা নাম্বার: ${pageNum + 1}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Date- ${bookmark.date}  Time- ${bookmark.time}',
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteBookmark(bookmark),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowPdfScreen(initialPage: pageNum),
                  ),
                );
              },
            ),
          );
        },
      ),*/

      ListView(
        children: [
          ..._bookmarks.map((page) {
            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShowPdfScreen(initialPage: page),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("বইয়ের পৃষ্ঠা নাম্বার: ${page + 1}",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () => _deleteBookmark(page),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),

    );
  }
}

import 'dart:convert';

import 'package:esho_eman_shikhi/model/save_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/data_controller.dart';
import 'showpdf_screen.dart';

class BookmarkScreen extends StatelessWidget {
  final List<SaveModel> bookmarks;

  const BookmarkScreen({super.key, required this.bookmarks});




  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DataController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("বুকমার্ক"),centerTitle: true,),
      body: bookmarks.isEmpty
          ? Center(child: Text("বইয়ের পৃষ্ঠা বুকমার্ক করা নেই।",style: TextStyle(fontSize: 20.sp),),)
          : ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final item = bookmarks[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.bookmark),
                title: Text("বইয়ের পৃষ্ঠা: ${int.parse(item.page) + 1}"),
                subtitle: Text("${item.date} - ${item.time}"),
                trailing: IconButton(
                  onPressed: () => controller.removeBookmark(item.page),
                  icon: const Icon(Icons.delete),
                ),
                onTap: (){
                  print("page: ${item.page}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ShowPdfScreen(
                        initialPage: int.tryParse(item.page)!,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

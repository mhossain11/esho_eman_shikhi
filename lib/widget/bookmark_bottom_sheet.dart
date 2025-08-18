import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../model/save_model.dart';

class BookmarkBottomSheet extends StatefulWidget {
  final List<SaveModel> bookmarkedPages; // SaveModel list
  final void Function(int page) onGoToPage;
  final void Function(List<SaveModel> updatedList) onBookmarksUpdated;

  const BookmarkBottomSheet({
    super.key,
    required this.bookmarkedPages,
    required this.onGoToPage,
    required this.onBookmarksUpdated,
  });

  @override
  State<BookmarkBottomSheet> createState() => _BookmarkBottomSheetState();
}

class _BookmarkBottomSheetState extends State<BookmarkBottomSheet> {
  late List<SaveModel> _localBookmarks;


  @override
  void initState() {
    super.initState();
    _localBookmarks = List<SaveModel>.from(widget.bookmarkedPages);
  }

  void _deleteBookmark(int index) {
    setState(() {
      _localBookmarks.removeAt(index);
    });
    widget.onBookmarksUpdated(_localBookmarks);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Container(
        color: Colors.white,
        child: _localBookmarks.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Center(
              child: Text(
                'বুকমার্ক তালিকা',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 23),
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: Center(child: Text('বইয়ের পৃষ্ঠা বুকমার্ক করা নেই।',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.sp),))),
          ],
        ) :
        ListView(
          padding: EdgeInsets.all(16),
          children: [
            Center(
              child: Text(
                'বুকমার্ক তালিকা',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 23),
              ),
            ),
            SizedBox(height: 10),
            ..._localBookmarks.asMap().entries.map((entry) {
              int index = entry.key;
              SaveModel item = entry.value;

              return Card(
                elevation: 5,
                child: ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: Text("বইয়ের পৃষ্ঠা: ${int.parse(item.page) + 1}"),
                  subtitle: Text("${item.date} - ${item.time}"),
                  trailing: IconButton(
                    onPressed: () => _deleteBookmark(index),
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: (){
                    print("page: ${item.page}");
                    Navigator.pop(context);
                    widget.onGoToPage(int.parse(item.page));
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}


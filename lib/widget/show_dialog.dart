import 'package:flutter/material.dart';

class BookmarkBottomSheet extends StatefulWidget {
  final List<int> bookmarkedPages;
  final void Function(int page) onGoToPage;
  final void Function(List<int> updatedList) onBookmarksUpdated;

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
  late List<int> _localBookmarks;

  @override
  void initState() {
    super.initState();
    _localBookmarks = List<int>.from(widget.bookmarkedPages); // local copy
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
      child: Container(
        color: Colors.white,
        child: ListView(
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
              int page = entry.value;
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.onGoToPage(page);
                },
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("বইয়ের পৃষ্ঠা নাম্বার: ${page+1}"),
                      IconButton(
                        onPressed: () => _deleteBookmark(index),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
      body: ListView(
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
                    Text("বইয়ের পৃষ্ঠা নাম্বার: ${page + 1}"),
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

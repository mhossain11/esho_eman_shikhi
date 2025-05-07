import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/show_dialog.dart';

class ShowPdfScreen extends StatefulWidget {
  final int pageNum;
  const ShowPdfScreen({super.key, required this.pageNum});

  @override
  State<ShowPdfScreen> createState() => _ShowPdfScreenState();
}

class _ShowPdfScreenState extends State<ShowPdfScreen> {
  PDFViewController? _pdfViewController;
  int _currentPage = 0;
  int _totalPages = 0;
  String? _filePath;
  bool _isReady = false;
  final List<int> _bookmarkedPages = [];
  final TextEditingController _pageSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
    _loadBookmarks();
  }

  Future<void> _loadPdfFromAssets() async {
    final bytes = await rootBundle.load('assets/pdf/iman.pdf');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/iman.pdf');
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
    setState(() {
      _filePath = file.path;
    });
  }

  void _goToPage(int pageNum) {
    if (_pdfViewController != null && pageNum >= 0 && pageNum < _totalPages) {
      _pdfViewController!.setPage(pageNum);
      setState(() {
        _currentPage = pageNum;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('দুঃখিত, এই নাম্বারের কোন পেইজ নেই।')),
      );
    }
  }

  void _toggleBookmark() {
    setState(() {
      if (_bookmarkedPages.contains(_currentPage)) {
        _bookmarkedPages.remove(_currentPage);
      } else {
        _bookmarkedPages.add(_currentPage);
      }
    });
    _saveBookmarks();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    // Int list → String list
    List<String> stringList = _bookmarkedPages.map((e) => e.toString()).toList();
    await prefs.setStringList('bookmarkedPages', stringList);
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('bookmarkedPages');

    if (stringList != null) {
      setState(() {
        _bookmarkedPages.clear();
        _bookmarkedPages.addAll(stringList.map((e) => int.parse(e)));
      });
    }
  }



  @override
  void dispose() {
    _pdfViewController = null;
    _pageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('এসো ঈমান শিখি', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              _bookmarkedPages.contains(_currentPage)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: Colors.black,
            ),
            onPressed: _toggleBookmark,
          ),
          IconButton(
            icon: Icon(Icons.list, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => BookmarkBottomSheet(
                  bookmarkedPages: List<int>.from(_bookmarkedPages),
                  onGoToPage: (int page) async{
                    _goToPage(page);
                    print('Page2 ${page + 1}');
                  },
                  onBookmarksUpdated: (List<int> updatedList) {
                    setState(() {
                      _bookmarkedPages
                        ..clear()
                        ..addAll(updatedList);
                    });
                    _saveBookmarks();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("পৃষ্ঠা খুঁজুন",style: TextStyle(fontWeight: FontWeight.bold),),
                  content: TextField(
                    controller: _pageSearchController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      iconColor: Colors.white,
                        hintText: "বইয়ের পৃষ্ঠা সংখ্যা ১-১৯২",
                        hintStyle: TextStyle(color: Colors.black12,fontSize: 16),

                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        int? page = int.tryParse(_pageSearchController.text);
                        if (page != null) {
                          Navigator.pop(context);
                          _goToPage(page-1);
                        }
                        _pageSearchController.clear();
                      },
                      child: Text("সার্চ করুন"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _filePath == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
            children: [
              PDFView(
                filePath: _filePath!,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: false,
                onRender: (pages){
                  _totalPages = pages!;
                  _isReady = true;
                },
                onViewCreated: (controller) {
                  _pdfViewController = controller;
                  _goToPage(widget.pageNum);
                },
                onPageChanged: (page, total) {
                  setState(() {
                    _currentPage = page!;
                    _totalPages = total!;
                  });
                },
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
              ),
              if (_isReady)
                Positioned(
                  bottom: 16,
                  right: 20,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Page ${_currentPage + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}


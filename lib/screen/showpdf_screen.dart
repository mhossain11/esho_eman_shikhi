import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/alert_dialog.dart';
import '../widget/show_dialog.dart';

class ShowPdfScreen extends StatefulWidget {
  final int initialPage;
  const ShowPdfScreen({super.key,this.initialPage = 0});

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
  bool nightMood=false;
  final TextEditingController _pageSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();
    _loadBookmarks();
    _loadNightMood();
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
    if (_pdfViewController == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF লোড হচ্ছে, একটু অপেক্ষা করুন।')),
      );
      return;
    }

    if (_totalPages == 0) {
      // এখনও render হয়নি, তাই render শেষে navigate করো
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 300), () {
          if (_pdfViewController != null) {
            _pdfViewController!.setPage(pageNum);
           // print('pageNum (delayed): ${pageNum+1}');
          }
        });
      });
    } else if (pageNum >= 0 && pageNum < _totalPages) {
      _pdfViewController!.setPage(pageNum);
     // print('pageNum: $pageNum');
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

  void _toggleNightMode() async {
    setState(() {
      nightMood = !nightMood;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('nightMood', nightMood);
  }


  Future<void> _loadNightMood() async {
    final prefs = await SharedPreferences.getInstance();
    nightMood = prefs.getBool('nightMood') ?? false;
  }




  @override
  void dispose() {
    _pageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: nightMood ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: nightMood ? Colors.white : Colors.black,
        ),
        actions: [
          /*IconButton(
            icon: Icon(
              nightMood ? Icons.nightlight_outlined
                  : Icons.nightlight,
              color: nightMood ? Colors.white : Colors.black,
            ),
            onPressed: (){
              _toggleNightMode();
            },
          ),*/
          IconButton(
            icon: Icon(
              _bookmarkedPages.contains(_currentPage)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
                color: nightMood ? Colors.white : Colors.black,
            ),
            onPressed: _toggleBookmark,
          ),
          IconButton(
            icon: Icon(Icons.list,
              color: nightMood ? Colors.white : Colors.black,),
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
            icon: Icon(Icons.search, color: nightMood ? Colors.white : Colors.black,),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialogs(
                  onGoToPage: (int page) {
                    _goToPage(page);
                  },
                  pageSearchController: _pageSearchController,),
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
                  setState(() {
                    _totalPages = pages!;
                    _isReady = true;
                  });
                  // Move to the desired initial page after rendering is complete
                  if (_pdfViewController != null) {
                    _pdfViewController!.setPage(widget.initialPage);
                    print('Navigated to initialPage: ${widget.initialPage}');
                  }
                },
                onViewCreated: (controller) {
                  _pdfViewController = controller;
                  _goToPage(widget.initialPage);
                  print('pageInit:${widget.initialPage}');
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


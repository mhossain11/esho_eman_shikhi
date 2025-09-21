import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../controller/data_controller.dart';
import '../model/save_model.dart';
import '../widget/alert_dialog.dart';
import '../widget/bookmark_bottom_sheet.dart';

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

  final TextEditingController _pageSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPdfFromAssets();

  }

  Future<void> _loadPdfFromAssets() async {

     try{

       // assets থেকে PDF bytes load
       final bytes = await rootBundle.load('assets/pdf/iman.pdf');
       //documents directory পাওয়া
       final dir = await getApplicationDocumentsDirectory();
       // ফাইল বানানো
       final file = File('${dir.path}/iman.pdf');
       //write as bytes
       await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

       //state update
       if (!mounted) return;
       setState(() {
         _filePath = file.path;
       });

     }catch(e){
       debugPrint("Error loading PDF: $e");
     }
  }


  void _goToPage(int pageNum) {
    if (_pdfViewController == null || _totalPages == 0) return;

    if (pageNum >= 0 && pageNum < _totalPages) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _pdfViewController?.setPage(pageNum);
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('এই নাম্বারের কোন পেইজ নেই।')),
      );
    }
  }





  @override
  void dispose() {
    _pageSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DataController>(context,listen:true );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          // বুকমার্ক বাটন
          IconButton(
            icon: Icon(
              controller.bookmarks.any((b) =>
              b.page == _currentPage.toString())
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: Colors.black ,
            ),
            onPressed: () {
              controller.toggleBookmarks(_currentPage);
            },
          ),

          // বুকমার্ক লিস্ট বটমশীট
          IconButton(
            icon: Icon(Icons.list, color: Colors.black ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => BookmarkBottomSheet(
                  bookmarkedPages: controller.bookmarks,
                  onGoToPage: (int page) {
                    _goToPage(page);
                  },
                  onBookmarksUpdated: (List<SaveModel> updatedList) {
                    // Provider দিয়ে update করতে হবে
                    controller.updateBookmarks(updatedList);
                  },
                ),
              );
            },
          ),

          // পেইজ সার্চ বাটন
          IconButton(
            icon: Icon(Icons.search, color:  Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialogs(
                  onGoToPage: (int page) {
                    _goToPage(page);
                  },
                  pageSearchController: _pageSearchController,
                ),
              );
            },
          ),
        ],
      ),

      body: _filePath == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          PDFView(
            filePath: _filePath!,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onError: (error){
              debugPrint("PDF error: $error");
            },
            onPageError: (page, error) {
              debugPrint("Page error on page $page: $error");
            },
            onRender: (pages) {
              // PDF completely loaded
              if (!mounted) return;
              setState(() {
                _totalPages = pages ?? 0;
                _isReady = true;
              });
              //_pdfViewController?.setPage(widget.initialPage);
              // safely go to initial page
              _goToPage(widget.initialPage);
            },
            onViewCreated: (controllerPDF) {
              _pdfViewController = controllerPDF;
              //_goToPage(widget.initialPage);
            },
            onPageChanged: (page, total) {
              if (!mounted) return;
              setState(() {
                _currentPage = page ?? 0;
                _totalPages = total ?? _totalPages;
              });
            },
          ),
          if (_isReady)
            Positioned(
              bottom: 16,
              right: 20,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Page ${_currentPage + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


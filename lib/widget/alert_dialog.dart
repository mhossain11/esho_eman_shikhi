import 'package:flutter/material.dart';

class AlertDialogs extends StatelessWidget {
   AlertDialogs({super.key, required this.onGoToPage,
     required this.pageSearchController});
  final void Function(int page) onGoToPage;
  final TextEditingController pageSearchController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("পৃষ্ঠা খুঁজুন",style: TextStyle(fontWeight: FontWeight.bold),),
      content: TextField(
        controller: pageSearchController,
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
            int? page = int.tryParse(pageSearchController.text);
            if (page != null) {
              Navigator.pop(context);
              onGoToPage(page-1);
            }
            pageSearchController.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // ✅ background color change
            foregroundColor: Colors.grey,
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text("সার্চ করুন",style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  }
}

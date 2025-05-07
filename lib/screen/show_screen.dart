import 'package:flutter/material.dart';

import '../model/text_model.dart';
import '../textlist/textList.dart';



class ShowScreen extends StatelessWidget {
  final int selectedIndex;
  const ShowScreen({super.key,
    required this.selectedIndex});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
              onPressed: (){},
              icon:Image.asset(
                'assets/images/fontsize.png',
                height: 24,
                width: 24,
              ))
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount:1,
        itemBuilder: (context, index) {
          index = selectedIndex;
          final item = dataList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Visibility(
                    visible: item.show,
                    child: Center(
                      child: Text(
                        item.arabic_title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Amiri',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.translation,
                    textAlign: TextAlign.justify,
                   // textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 16),
                  ),
                  if (item.description.isNotEmpty) ...[
                    Text(
                      item.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                  if (item.reference.isNotEmpty) ...[
                    SizedBox(height: 12),
                    Visibility(
                        visible: item.referenceShow,
                        child: Divider(height: 24)),
                    Visibility(
                      visible: item.referenceShow,
                      child: Text(
                        'রেফারেন্স:\n${item.reference}',
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../textlist/textList.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  double width = 0;
  bool myAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        myAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.sizeOf(context).width;
    var heightSize = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        width: widthSize,
        height: heightSize,
        color: Colors.green,
        child: Row(   // 🔥 Column না, Row ইউজ করবো
          children: [
            // Sidebar
            Container(
              width: widthSize * 0.3,
              height: heightSize,
              color: Colors.red,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'সূচিপত্র',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Expanded(  // 🔥 Expanded দিয়ে ListView নেবো
                    child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final data = dataList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400 + (index * 250)),
                            curve: Curves.decelerate,
                            transform: Matrix4.translationValues(myAnimation ? 0 : width, 0, 0),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                //  Navigator.push(context, MaterialPageRoute(builder: (_) => DedicationScreen()));
                                } else if (index == 1) {
                                 // Navigator.push(context, MaterialPageRoute(builder: (_) => AuthorWordsScreen()));
                                } else {
                                 /* Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => ShowScreen(textLists: textList, selectedIndex: index)));*/
                                }
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Area (Right Side)
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Main Content Area',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:esho_eman_shikhi/screen/show_screen.dart';
import 'package:esho_eman_shikhi/screen/showpdf_screen.dart';
import 'package:flutter/material.dart';

import '../textlist/textList.dart';
import 'author_words_screen.dart';
import 'dedication_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(
        title: Text('সূচিপত্র',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final data = dataList[index];
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
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
                          Navigator.push(context, MaterialPageRoute(builder: (_) => DedicationScreen()));
                        } else if (index == 1) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AuthorWordsScreen()));
                        } else {
                         // Navigator.push(context, MaterialPageRoute(builder: (_) => ShowScreen(selectedIndex: index)));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ShowPdfScreen(pageNum: index,)));
                        }

                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: widthSize * 0.7,
                          height: heightSize * 0.1,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                  fontFamily: 'SutonyMJ',
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
          ],
        ),
      ),
    );
  }
}

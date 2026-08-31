
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/background_image.dart';
import '../widget/gridview_items.dart';
import '../widget/text.dart';


class Homepage extends StatefulWidget {
  const  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAppOpenCount();
    });
  }

  Future<void> checkAppOpenCount() async {
    final prefs = await SharedPreferences.getInstance();

    // Get previous count.
    int openCount = prefs.getInt('app_open_count') ?? 0;

    // Increase count.
    openCount++;

    // Save count.
    await prefs.setInt('app_open_count', openCount);

    // Show popup only for first 3 opens.
    if (openCount <= 3 && mounted) {
      showMyDialog();
    }
  }

  void showMyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'সংশোধনী নোটিশ',
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),

          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Text(
                AppTexts.correctionNotice,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),

          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ঠিক আছে'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: isLandscape ? null : AppBar(backgroundColor: Colors.white),
    //   body: Stack(
    //     children: [
    //       // Background image
    //       Align(
    //           alignment: isLandscape
    //               ? Alignment.center // landscape হলে মাঝখানে আসবে
    //               : Alignment.topCenter,
    //           child: BackgroundImage(isLandscape: isLandscape)),
    //
    //       // Grid items
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: GridViewItems(isLandscape: isLandscape),
    //       ),
    //
    //       Text('App Version- 1.1.1' )
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isLandscape
          ? null
          : AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Background image
          Transform.translate(
            offset: const Offset(0, -50),
            child: Align(
              alignment: isLandscape
                  ? Alignment.center
                  : Alignment.topCenter,
              child: BackgroundImage(
                isLandscape: isLandscape,
              ),
            ),
          ),

          // Grid + Version
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GridViewItems(
                  isLandscape: isLandscape,
                ),

                const SizedBox(height: 4),

                const Text(
                  'Version - 1.1.1',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





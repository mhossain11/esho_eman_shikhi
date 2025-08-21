
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/background_image.dart';
import '../widget/gridview_items.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});



  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isLandscape ? null : AppBar(backgroundColor: Colors.white),
      body: Stack(
        children: [
          // Background image
          BackgroundImage(isLandscape: isLandscape),

          // Grid items
          Align(
            alignment: Alignment.bottomCenter,
            child: GridViewItems(isLandscape: isLandscape),
          ),
        ],
      ),
    );
  }
}





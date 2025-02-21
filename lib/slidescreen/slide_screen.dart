import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:week7/slidescreen/slide_pages.dart';



class SlideViewScreen extends StatefulWidget {
  @override
  _SlideViewScreenState createState() => _SlideViewScreenState();
}

class _SlideViewScreenState extends State<SlideViewScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              
              controller: _pageController,
              children: [
                SlideScreen1(),
                SlideScreen2(),
                SlideScreen3(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            // padding: EdgeInsetsDirectional.only(bottom: 20),
            child: SmoothPageIndicator(

              controller: _pageController, 
              count: 3,
              effect: WormEffect(), 
            ),
          ),
        ],
      ),
    );
  }
}

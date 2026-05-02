import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/widgets/custom_animated_button.dart';
import '../widgets/onboarding_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final PageController _controller;
  bool isLasd = false;
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.centerRight,
            child: Visibility(
              replacement: const SizedBox(height: 50),
              visible: !isLasd,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: _controller,
              itemCount: onBoardingPages.length,
              onPageChanged: (value) {
                if (value == onBoardingPages.length - 1) {
                  setState(() {
                    isLasd = true;
                  });
                } else {
                  setState(() {
                    isLasd = false;
                  });
                }
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 130),
                    Image.asset(
                      onBoardingPages[index].imagePath,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      onBoardingPages[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onBoardingPages[index].subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            effect: const ExpandingDotsEffect(
              dotColor: Colors.black12,
              activeDotColor: Color(0xFF983B3B),
              dotHeight: 10,
              dotWidth: 15,
            ),
            count: onBoardingPages.length,
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomAnimatedButton(
              text: isLasd ? 'Start' : 'Next',
              onClick: () {
                if (!isLasd) {
                  _controller.animateToPage(
                    _controller.page!.toInt() + 1,
                    duration: Duration(seconds: 1),
                    curve: Curves.ease,
                  );
                } else {
                  context.go('/login');
                }
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

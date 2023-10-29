// ignore_for_file: depend_on_referenced_packages

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:panda_technician/services/firstTimeRun.dart';
import 'auth/LoginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingSlider extends StatefulWidget {
  const OnboardingSlider({super.key});
  static const routeName = '/onboarding-slider';
  @override
  State<OnboardingSlider> createState() => _OnboardingSliderState();
}

class _OnboardingSliderState extends State<OnboardingSlider> {
  int activeIndex = 0;
  CarouselController controller = CarouselController();

  var checked = false;

  @override
  void initState() {
    super.initState();
    checkFirstTimeLoad(context, (() {
      checked = true;
    }));
  }

  Widget getComponent(String title, String body) {
    return SingleChildScrollView(
        child: (checked)
            ? ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Center(
                        child: Image.asset("./assets/HeaderLogo.png"),
                      ),
                      const SizedBox(
                        height: 140,
                      ),
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(body),
                    ],
                  ),
                ))
            : ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Center(
                        child: Image.asset("./assets/HeaderLogo.png"),
                      ),
                      const SizedBox(
                        height: 140,
                      ),
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(body),
                    ],
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      getComponent("Onboarding Screen One",
          "Take control of your earning power by setting your rates, and service your customers with an easy-to-use platform."),
      getComponent("Onboarding Screen Two",
          "ThePanda is an all-in-one platform to operate your mobile mechanic business"),
      getComponent("Onboarding Screen three",
          "We will send a customer request to your dashboard so you can complete the repair, and accept payment.")
    ];
    Widget buildIndicator() {
      return AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: items.length,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          CarouselSlider.builder(
            carouselController: controller,
            itemCount: items.length,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height - 150,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              viewportFraction: 0.9,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    items[itemIndex],
          ),
          const SizedBox(
            height: 32,
          ),
          buildIndicator(),
          buildButton()
        ],
      ),
    );
  }

  Widget buildButton({bool stretch = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              setFirstTimeLoad();

              Navigator.popAndPushNamed(
                context,
                "Login",
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          activeIndex == 2
              ? ElevatedButton(
                  onPressed: () {
                    setFirstTimeLoad();

                    Navigator.pushNamed(context, "Login");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 17, 168, 143),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                  child: const Text('Get Stated'),
                )
              : ElevatedButton(
                  onPressed: () => controller.nextPage(),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 17, 168, 143),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                  child: const Text('Next'),
                ),
        ],
      ),
    );
  }

  void next() => controller.nextPage();
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:societ_act/controllers/onboarding_controller.dart';
import 'package:societ_act/models/onboarding_class.dart';
import 'package:societ_act/utils/primary_button.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key}) : super(key: key);

  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final _controller = OnboardingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 0),
              color: const Color(0xFFEDF1F4),
              child: Column(
                children: [
                  Image(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    image: const AssetImage('assets/avatar-images.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: _controller.selectedPageIndex,
                      controller: _controller.pageController,
                      itemCount: _controller.onboardingPages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0,
                                        bottom: 10,
                                        top: 30,
                                        right: 40),
                                    child: Text(
                                      _controller.onboardingPages[index].title,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40.0, right: 40, bottom: 20),
                                    child: Text(
                                      _controller.onboardingPages[index].text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 100,
              left: 50,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 5,
                // color: const Color(0xFFEDF1F4),
                child: Row(
                  children: List.generate(
                    _controller.onboardingPages.length,
                    (index) => Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: _controller.selectedPageIndex.value == index
                              ? 80
                              : 40,
                          color: _controller.selectedPageIndex.value == index
                              ? const Color(0xFF1D3557)
                              : const Color(0xFFA8DADC),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: PrimaryButton(
                text: 'Get Started',
                onTap: () {
                  Navigator.of(context).pushNamed('login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:societ_act/classes/onboarding_class.dart';
import 'package:societ_act/utils/primary_button.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key}) : super(key: key);

  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  // int? count;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                  itemCount: OnboardingItems.item()!.length,
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
                                    left: 40.0, bottom: 10, top: 30, right: 40),
                                child: Text(
                                  OnboardingItems.item()![index].title,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40, bottom: 20),
                                child: Text(
                                  OnboardingItems.item()![index].text,
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
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, bottom: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 6,
                            // color: const Color(0xFFEDF1F4),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: OnboardingItems.item()!.length,
                              itemBuilder: (BuildContext context, int count) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: index == count ? 80 : 40,
                                    color: index == count
                                        ? const Color(0xFF1D3557)
                                        : const Color(0xFFA8DADC),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              PrimaryButton(
                text: 'Get Started',
                onTap: () {
                  Navigator.of(context).pushNamed('login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

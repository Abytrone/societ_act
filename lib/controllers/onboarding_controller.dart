import 'package:flutter/material.dart';
import 'package:societ_act/models/onboarding_class.dart';
import 'package:get/state_manager.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  List<OnboardingItem> onboardingPages = [
    const OnboardingItem(
        title: 'Society\nActs',
        text:
            'Connecting people to problems to be solved to create a better environment for the future. Try connect and help'),
    const OnboardingItem(
        title: 'Network',
        text:
            'Join with other partners on Society acts and pull each other\'s unique capabilities together to impact society through network'),
    const OnboardingItem(
        title: 'Cases',
        text:
            'If it requires public intervention; it can be whether individual or collective, developmental or preservational, publicize as cases'),
    const OnboardingItem(
        title: 'Partners',
        text:
            'Volunteers dedicate their skills, abilities, time and energies to serve and make effect changes in society\n\nActivists impact society through advocacy, publicity and campaigning\n\nSponsors are agents of change through committing their resources')
  ];
}

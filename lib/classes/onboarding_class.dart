class OnboardingItem {
  final String title;
  final String text;

  const OnboardingItem({required this.title, required this.text});
}

class OnboardingItems {
  static List<OnboardingItem>? item() {
    const it = <OnboardingItem>[
      OnboardingItem(
          title: 'Society\nActs',
          text:
              'Connecting people to problems to be solved to create a better environment for the future. Try connect and help'),
      OnboardingItem(
          title: 'Network',
          text:
              'Join with other partners on Society acts and pull each other\'s unique capabilities together to impact society through network'),
      OnboardingItem(
          title: 'Cases',
          text:
              'If it requires public intervention; it can be whether individual or collective, developmental or preservational, publicize as cases'),
      OnboardingItem(
          title: 'Partners',
          text:
              'Volunteers dedicate their skills, abilities, time and energies to serve and make effect changes in society\n\nActivists impact society through advocacy, publicity and campaigning\n\nSponsors are agents of change through committing their resources')
    ];
    return it;
  }
}

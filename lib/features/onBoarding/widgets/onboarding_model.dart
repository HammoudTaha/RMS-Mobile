class OnboardingModel {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

final List<OnboardingModel> onBoardingPages = [
  const OnboardingModel(
    imagePath: 'assets/images/F.png',
    title: 'Welcome To Tasty Restaurant',
    subtitle: 'You Are Welcome To Tasty ,We Strive\n To offer The Best',
  ),
  const OnboardingModel(
    imagePath: 'assets/images/D.png',
    title: 'EfortLess Ordering',
    subtitle: 'Taste And Order Your Favorite\n Foods Seamlessly',
  ),
  const OnboardingModel(
    imagePath: 'assets/images/A.png',
    title: 'Easy Table Booking',
    subtitle: 'Reserve Your Table Conveniently',
  ),
  const OnboardingModel(
    imagePath: 'assets/images/E.png',
    title: 'Scure Payment',
    subtitle: 'Scure Online Payment\n And Reliable',
  ),
];

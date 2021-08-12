class Onboarding {
  final String imageName;
  final String title;
  final String description;
  Onboarding({this.imageName, this.title, this.description});
}

List<Onboarding> onboardingModels = 
[
  Onboarding(description: 'enjoy',imageName:'images/onboarding_1.jpg' ,title: 'Step 1'),
  Onboarding(description: 'buy',imageName: 'images/onboarding_1.jpg',title: 'Step 2'),
  Onboarding(description: 'easily',imageName: 'images/onboarding_1.jpg',title: 'Step 3'),
];

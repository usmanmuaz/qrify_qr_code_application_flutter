class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

// Onboading List

final List<OnboardingItem> onboardingData = [
  OnboardingItem(
    title: "Scan QR Code",
    description:
        "Use your camera to scan QR codes and access information instantly.",
    image: "images/scanner.svg",
  ),
  OnboardingItem(
    title: "Generate QR Code",
    description:
        "Create QR codes for your data and share them with others easily.",
    image: "images/generator.svg",
  ),
  // Add more onboarding screens as needed
];

String getDisplayValue(String? value) {
  final displayValue = value ?? 'Not provided';
  return displayValue;
}

int getUsernameLength(String? username) {
  return username?.length ?? 0;
}

void printDeveloperProfile(
  String developerName,
  String? githubUsername,
  String? portfolioUrl,
) {
  final displayGithub = getDisplayValue(githubUsername);
  final portfolioDisplay = getDisplayValue(portfolioUrl);
  final userLength = getUsernameLength(githubUsername);

  print('=== DEVELOPER PROFILE ===');
  print('Developer: $developerName');
  print('GitHub: $displayGithub');
  print('Username length: $userLength');
  print('Portfolio: $portfolioDisplay');
  print('=========================');
}

void main() {
  final developerName = 'Lary';
  String? githubUsername;
  String? portfolioUrl = 'https://example.com';

  printDeveloperProfile(developerName, githubUsername, portfolioUrl);
}

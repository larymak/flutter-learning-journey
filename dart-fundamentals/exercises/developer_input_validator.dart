int parseDeveloperAge(String ageInput) {
  final age = int.parse(ageInput);
  return age;
}

void validateDeveloperAge(int age) {
  if (age < 18) {
    throw Exception('Developer must be at least 18.');
  }
}

bool registerDeveloper(String name, String ageInput) {
  try {
    final newAge = parseDeveloperAge(ageInput);
    validateDeveloperAge(newAge);
    print('Developer $name registered successfully.');
    return true;
  } catch (error) {
    print('Registration failed for $name: $error');
    return false;
  }
}

void main() {
  final registrations = [
    {'name': 'Lary', 'age': '25'},
    {'name': 'Alex', 'age': '16'},
    {'name': 'Sam', 'age': 'unknown'},
    {'name': 'Nina', 'age': '30'},
  ];

  int acceptedCount = 0;
  print('=== DEVELOPER REGISTRATION REPORT ===');

  for (final registration in registrations) {
    final name = registration['name']!;
    final ageInput = registration['age']!;
    final accepted = registerDeveloper(name, ageInput);
    if (accepted) {
      acceptedCount++;
    }
  }

  final rejectedCount = registrations.length - acceptedCount;
  print('');
  print('Total registrations: ${registrations.length}');
  print('Accepted registrations: $acceptedCount');
  print('Rejected registrations: $rejectedCount');
  print('=====================================');
}

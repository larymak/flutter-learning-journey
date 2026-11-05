class Developer {
  String name;
  String? githubUsername;
  int _completedProjects;

  Developer(this.name, this.githubUsername, this._completedProjects);

  void introduce() {
    print('I am $name, a developer.');
  }

  int get completedProjects => _completedProjects;

  void addProjects(int amount) {
    if (amount >= 1) {
      _completedProjects += amount;
    } else {
      throw Exception('Project amount must be positive.');
    }
  }

  void showProfile() {
    final displayValue = githubUsername ?? 'Not provided';
    print('Developer: $name');
    print('GitHub: $displayValue');
    print('Completed projects: $completedProjects');
  }
}

class FlutterDeveloper extends Developer {
  FlutterDeveloper(String name, String? githubUsername, int completedProjects)
    : super(name, githubUsername, completedProjects);

  @override
  void introduce() {
    print('I am $name, a Flutter developer.');
  }
}

class BackendDeveloper extends Developer {
  BackendDeveloper(String name, String? githubUsername, int completedProjects)
    : super(name, githubUsername, completedProjects);

  @override
  void introduce() {
    print('I am $name, a backend developer.');
  }
}

void main() {
  int totalProjects = 0;
  final List<Developer> developers = [
    FlutterDeveloper('Lary', 'larymak', 4),
    BackendDeveloper('Alex', null, 7),
    Developer('Sam', 'samdev', 2),
    FlutterDeveloper('Nina', 'ninacodes', 5),
  ];

  print('=== DEVELOPER REGISTRY REPORT ===');
  for (final developer in developers) {
    developer.introduce();
    developer.showProfile();
    totalProjects += developer.completedProjects;
  }

  print('');
  print('Total developers: ${developers.length}');
  print('Total completed projects: $totalProjects');
  print('================================');
}

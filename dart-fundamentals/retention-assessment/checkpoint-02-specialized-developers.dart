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
  final developer1 = FlutterDeveloper('Lary', 'larymak', 4);
  final developer2 = BackendDeveloper('Alex', null, 7);

  developer1.introduce();
  developer2.introduce();
  developer2.showProfile();
}

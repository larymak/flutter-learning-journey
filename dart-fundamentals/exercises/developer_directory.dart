class Developer {
  String name;
  int _completedProjects;

  Developer(this.name, this._completedProjects);

  int get completedProjects => _completedProjects;

  void completeProject() {
    _completedProjects++;
  }

  void addProjects(int amount) {
    if (amount > 0) {
      _completedProjects += amount;
    }
  }

  void showProfile() {
    print('Developer: $name');
    print('Completed projects: $completedProjects');
  }
}

void main() {
  int totalProjects = 0;
  final developers = [
    Developer('Lary', 4),
    Developer('Alex', 7),
    Developer('Sam', 2),
  ];

  developers[0].completeProject();
  developers[1].addProjects(3);
  developers[2].addProjects(-2);

  print('=== DEVELOPER DIRECTORY REPORT ===');
  for (final developer in developers) {
    developer.showProfile();
    totalProjects += developer.completedProjects;
  }
  print('');
  print('Total developers: ${developers.length}');
  print('Total completed projects: $totalProjects');
  print('================================');
}

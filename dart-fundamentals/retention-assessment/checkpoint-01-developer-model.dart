class Developer {
  String name;
  String? githubUsername;
  int _completedProjects;

  Developer(this.name, this.githubUsername, this._completedProjects);

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

void main() {
  final developer = Developer('Lary', null, 4);
  developer.addProjects(2);
  developer.showProfile();
}

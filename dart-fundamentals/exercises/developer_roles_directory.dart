class Developer {
  String name;

  Developer(this.name);

  void introduce() {
    print('I am $name, a developer.');
  }
}

class FlutterDeveloper extends Developer {
  FlutterDeveloper(String name) : super(name);

  @override
  void introduce() {
    print('I am $name, a Flutter developer.');
  }
}

class BackendDeveloper extends Developer {
  BackendDeveloper(String name) : super(name);

  @override
  void introduce() {
    print('I am $name, a backend developer.');
  }
}

void main() {
  final List<Developer> developers = [
    FlutterDeveloper('Lary'),
    BackendDeveloper('Alex'),
    Developer('Sam'),
    FlutterDeveloper('Nina'),
  ];

  int specializedCount = 0;
  print('=== DEVELOPER ROLES REPORT ===');

  for (final developer in developers) {
    developer.introduce();
    if (developer is FlutterDeveloper || developer is BackendDeveloper) {
      specializedCount++;
    }
  }

  final generalCount = developers.length - specializedCount;
  print('');
  print('Total developers: ${developers.length}');
  print('Specialized developers: $specializedCount');
  print('General developers: $generalCount');
  print('==============================');
}

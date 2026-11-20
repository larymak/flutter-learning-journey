import 'package:flutter/material.dart';

void main() {
  print('My Flutter learning journey has started!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter Journey',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int completedProjects = 4;
  String developerName = 'Lary';
  String? nameError;
  final nameController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementProjects() {
    setState(() {
      completedProjects++;
    });
  }

  void _resetProjects() {
    setState(() {
      completedProjects = 4;
    });
  }

  void _updateProfile() {
    if (nameController.text.trim().isEmpty) {
      setState(() {
        nameError = 'Name cannot be empty';
      });
      print('Name cannot be empty');
      return;
    }
    setState(() {
      developerName = nameController.text;
      nameError = null;
    });
  }

  void _openProjects() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProjectsScreen(
          completedProjects: completedProjects,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My First Flutter App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to my Flutter learning journey!',
                style: TextStyle(fontSize: 24),
              ),
              const Text(
                'I am learning Flutter!',
                style: TextStyle(fontSize: 24),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            Text(developerName),
                            const Text('Flutter Developer'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Completed Projects'),
                        Text('$completedProjects'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _incrementProjects,
                      child: const Text('Complete a Project'),
                    ),
                    ElevatedButton(
                      onPressed: _resetProjects,
                      child: const Text('Reset Projects'),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Developer Name',
                        errorText: nameError,
                      ),
                      controller: nameController,
                    ),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      child: const Text('Update Profile'),
                    ),
                    ElevatedButton(
                      onPressed: _openProjects,
                      child: const Text('View My Projects'),
                    ),
                  ],
                ),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key, required this.completedProjects});

  final int completedProjects;

  static const List<String> projectNames = [
    'Developer Profile Card',
    'Project Tracker',
    'Profile Editor',
  ];

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<String> projects = List<String>.of(ProjectsScreen.projectNames);

  void _addProject() {
    setState(() {
      projects.add('Portfolio App');
    });
  }

  void _removeProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Completed Projects: ${widget.completedProjects}'),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.folder),
                    title: Text(projects[index]),
                    subtitle: const Text('Flutter learning project'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeProject(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addProject,
              child: const Text('Add Project'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

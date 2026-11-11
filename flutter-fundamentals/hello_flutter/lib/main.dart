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
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My First Flutter App'),
      ),
      body: Center(
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
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(radius: 28, child: Icon(Icons.person)),
                          SizedBox(width: 12),
                          Column(
                            children: [Text('Lary'), Text('Flutter Developer')],
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
                    ],
                  ),
                ),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
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

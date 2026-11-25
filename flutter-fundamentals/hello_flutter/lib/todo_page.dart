import 'package:material_ui/material_ui.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final List<String> tasks = [
    'Learn Dart',
    'Practice Flutter',
    'Write Documentation',
    'Build Flutter App',
  ];

  String searchQuery = '';

  void _updateSearch(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks
        .where((task) => task.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          SearchBox(onQueryChanged: _updateSearch),
          Expanded(child: TaskList(tasks: filteredTasks)),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchBox({super.key, required this.onQueryChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: onQueryChanged);
  }
}

class TaskList extends StatelessWidget {
  final List<String> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(tasks[index]));
      },
    );
  }
}

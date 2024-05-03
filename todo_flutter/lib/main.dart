import 'package:todo_client/todo_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Serverpod Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _textEditingController = TextEditingController();

  void _saveTodo() async {
    try {
      final Todo todo = Todo(
        title: _textEditingController.text,
        description: "test",
        isChecked: false,
        createdAt: DateTime.now(),
      );
      final result = await client.todoEndPoint.addTodo(todo);
      counter++;
      debugPrint(result.toString());
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'title ',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: _saveTodo,
                child: const Text('Save'),
              ),
            ),
            Expanded(
              child: TodoListView(
                key: ValueKey(counter),
                update: counter,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TodoListView extends StatefulWidget {
  const TodoListView({super.key, this.update = 0});
  final int update;

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  Future<List<Todo>> _getTodos() async {
    try {
      final result = await client.todoEndPoint.getTodos()
        ..sort(
          (a, b) => a.createdAt.compareTo(b.createdAt),
        );
      return result;
    } catch (e) {
      setState(() {});
      return [];
    }
  }

  late Future<List<Todo>> future = _getTodos();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return CheckboxListTile(
                title: Text(item.title),
                subtitle: Text(item.description),
                value: item.isChecked,
                onChanged: (value) async {
                  await client.todoEndPoint.toggleTodo(item);
                  future = _getTodos();
                  setState(() {});
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

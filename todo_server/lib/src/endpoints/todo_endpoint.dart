import 'package:serverpod/serverpod.dart';
import 'package:todo_server/src/generated/todo_item.dart';
// creating a public method with `Session` as its first parameter.
// `bool`, `int`, `double`, `String`, `UuidValue`, `Duration`, `DateTime`, `ByteData`,

class TodoEndPoint extends Endpoint {
  Future<Todo> addTodo(Session session, Todo todo) async {
    await Todo.db.insertRow(session, todo);
    return todo;
  }

  Future<bool> toggleTodo(Session session, Todo todo) async {
    todo.isChecked = !todo.isChecked;
    await Todo.db.updateRow(session, todo);
    return todo.isChecked;
  }

  Future<List<Todo>> getTodos(Session session, {int? id}) async {
    if (id == null) {
      return await Todo.db.find(session);
    } else {
      final result = await Todo.db.findById(session, id);
      return result == null ? [] : [result];
    }
  }
}

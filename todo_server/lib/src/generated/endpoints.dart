/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/todo_endpoint.dart' as _i2;
import 'package:todo_server/src/generated/todo_item.dart' as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'todoEndPoint': _i2.TodoEndPoint()
        ..initialize(
          server,
          'todoEndPoint',
          null,
        )
    };
    connectors['todoEndPoint'] = _i1.EndpointConnector(
      name: 'todoEndPoint',
      endpoint: endpoints['todoEndPoint']!,
      methodConnectors: {
        'addTodo': _i1.MethodConnector(
          name: 'addTodo',
          params: {
            'todo': _i1.ParameterDescription(
              name: 'todo',
              type: _i1.getType<_i3.Todo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todoEndPoint'] as _i2.TodoEndPoint).addTodo(
            session,
            params['todo'],
          ),
        ),
        'toggleTodo': _i1.MethodConnector(
          name: 'toggleTodo',
          params: {
            'todo': _i1.ParameterDescription(
              name: 'todo',
              type: _i1.getType<_i3.Todo>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todoEndPoint'] as _i2.TodoEndPoint).toggleTodo(
            session,
            params['todo'],
          ),
        ),
        'getTodos': _i1.MethodConnector(
          name: 'getTodos',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['todoEndPoint'] as _i2.TodoEndPoint).getTodos(
            session,
            id: params['id'],
          ),
        ),
      },
    );
  }
}

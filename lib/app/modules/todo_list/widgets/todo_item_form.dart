import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../todo_list_cubit.dart';

class TodoItemForm extends StatefulWidget {
  const TodoItemForm({super.key});

  @override
  State<TodoItemForm> createState() => _TodoItemFormState();
}

class _TodoItemFormState extends State<TodoItemForm> {
  final _formKey = GlobalKey<FormState>();

  final _contentEC = TextEditingController();

  @override
  void dispose() {
    _contentEC.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      final cubit = context.read<TodoListCubit>();
      final navigator = Navigator.of(context);
      await cubit.createTodo(_contentEC.text);
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            TextFormField(
              controller: _contentEC,
              decoration: const InputDecoration(
                labelText: 'Content',
                hintText: 'Drink water',
                isDense: true,
              ),
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                _handleSubmit();
              },
              maxLength: 140,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              validator: Validatorless.multiple([
                Validatorless.required('cannot be empty'),
                Validatorless.min(4, 'minimum 4 characters'),
                Validatorless.max(140, 'maximum 140 characters'),
              ]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}

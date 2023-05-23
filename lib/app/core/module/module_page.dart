import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({
    required WidgetBuilder builder,
    super.key,
    List<SingleChildWidget>? binds,
  })  : _builder = builder,
        _binds = binds;

  final WidgetBuilder _builder;

  final List<SingleChildWidget>? _binds;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _binds != null && _binds!.isNotEmpty
          ? _binds!
          :
          // Multiprovider throws an error when providers is empty
          // to prevent this we need to create a dummy provider
          [
              Provider(
                create: (context) => Object(),
              ),
            ],
      builder: (context, child) => _builder(context),
    );
  }
}

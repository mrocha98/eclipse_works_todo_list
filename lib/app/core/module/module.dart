import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import 'module_page.dart';

abstract class Module {
  Module({
    required Map<String, WidgetBuilder> routes,
    List<SingleChildWidget>? binds,
  })  : _routes = routes,
        _binds = binds;

  final Map<String, WidgetBuilder> _routes;

  final List<SingleChildWidget>? _binds;

  Map<String, WidgetBuilder> get routes => _routes.map(
        (routeName, builder) => MapEntry(
          routeName,
          (_) => ModulePage(
            builder: builder,
            binds: _binds,
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  /// get a read-only copy of binds or a list with single dummy provider
  List<SingleChildWidget> get binds =>
      _binds?.toList(growable: false) ?? [Provider(create: (_) => Object())];
}

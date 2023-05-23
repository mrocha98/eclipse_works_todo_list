import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Eclipse Works Todo List',
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Bem começado, metade feito'),
        ),
      ),
    );
  }
}

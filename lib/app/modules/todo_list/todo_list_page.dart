import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/widgets/default_app_bar.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const DefaultAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: ToggleButtons(
                  isSelected: const [true, false, false],
                  onPressed: (index) {},
                  constraints: BoxConstraints(
                    minHeight: 38,
                    minWidth: context.percentWidth(.3) - 12,
                  ),
                  children: const [
                    Text('All'),
                    Text('pending'),
                    Text('done'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListView.separated(
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    confirmDismiss: (_) async {
                      return null;
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.only(right: 12),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'DELETE',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: CheckboxListTile(
                      activeColor: Theme.of(context).primaryColor,
                      value: index.isEven,
                      onChanged: (value) {},
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('${index + 1} lorem ipsum dolor est'),
                    ),
                  ),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: 10,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LogHistoryRoute extends StatelessWidget {
  const LogHistoryRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Logged Entries:",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              ListEntryMealLog(),
              ListEntryMealLog(),
            ],
          ),
        )
      ],
    );
  }
}

class ListEntryMealLog extends StatelessWidget {
  const ListEntryMealLog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(200),
          onTap: () {
            debugPrint("tapped");
          },
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            const ListTile(
              leading: Icon(Icons.food_bank),
              title: Text('day/mth/year'),
            ),
            ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // To do
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // To do
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

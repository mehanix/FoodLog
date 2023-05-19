import 'dart:collection';

import 'package:dezvapmobile/model/FoodLog.dart';
import 'package:dezvapmobile/model/FoodLogList.dart';
import 'package:dezvapmobile/storage_service.dart';
import 'package:dezvapmobile/util/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogHistoryRoute extends StatefulWidget {
  const LogHistoryRoute({
    super.key,
  });

  @override
  State<LogHistoryRoute> createState() => _LogHistoryRouteState();
}

class _LogHistoryRouteState extends State<LogHistoryRoute> {
  bool isGridView = true;
  final Storage storage = Storage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UnmodifiableListView<FoodLog> logList =
        Provider.of<FoodLogProvider>(context).items;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text("Entries:",
                style: TextStyle(
                    fontFamily: 'Satisfy',
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            IconButton(
                onPressed: () {
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
                icon: isGridView ? Icon(Icons.list) : Icon(Icons.grid_view))
          ],
        ),
      ),
      Expanded(
          child: isGridView
              ? GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemCount: logList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            if (logList[index].photo != null)
                              FutureBuilder(
                                  future: storage
                                      .downloadURL(logList[index].photo!),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Image.network(snapshot.data!,
                                          height: 130, fit: BoxFit.cover);
                                    } else {
                                      return Icon(Icons.image);
                                    }
                                  }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Date: ${logList[index].date!}"),
                                  Text("Food: ${logList[index].foodName!}"),
                                  Text(
                                      "Calories: ${logList[index].calories ?? "not set"}"),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
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
                                  onPressed: () async {
                                    Provider.of<FoodLogProvider>(context,
                                            listen: false)
                                        .remove(logList[index]
                                            .id!); // await _dbHelper
                                    //     .deleteFoodLog(_logs[index].id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Log deleted!')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: logList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.food_bank),
                              title: Text(
                                logList[index].date!,
                              ),
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
                                  onPressed: () async {
                                    Provider.of<FoodLogProvider>(context,
                                            listen: false)
                                        .remove(logList[index].id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Log deleted!')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
                ))
    ]);
  }
}

import 'package:dezvapmobile/model/FoodLog.dart';
import 'package:dezvapmobile/util/database_helper.dart';
import 'package:flutter/material.dart';

class LogHistoryRoute extends StatefulWidget {
  const LogHistoryRoute({
    super.key,
  });

  @override
  State<LogHistoryRoute> createState() => _LogHistoryRouteState();
}

class _LogHistoryRouteState extends State<LogHistoryRoute> {
  late DatabaseHelper _dbHelper;
  bool isGridView = false;
  List<FoodLog> _logs = [];

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshFoodLogList();
  }

  _refreshFoodLogList() async {
    List<FoodLog> x = await _dbHelper.fetchFoodLogs();
    setState(() {
      _logs = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text("Entries:",
                  style: TextStyle(
                    fontFamily: 'Satisfy',
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  )),
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
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, childAspectRatio: 1),
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        ListTile(
                          title: Text(
                            _logs[index].date!,
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
                                await _dbHelper.deleteFoodLog(_logs[index].id!);
                                _refreshFoodLogList();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Log deleted!')),
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
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        ListTile(
                          leading: Icon(Icons.food_bank),
                          title: Text(
                            _logs[index].date!,
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
                                await _dbHelper.deleteFoodLog(_logs[index].id!);
                                _refreshFoodLogList();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Log deleted!')),
                                );
                              },
                            ),
                          ],
                        ),
                      ]),
                    );
                  },
                ),
        )
      ],
    );
  }
}

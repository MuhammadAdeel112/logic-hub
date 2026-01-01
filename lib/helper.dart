import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Alert Dialog with List')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('List of Items'),
                    content: Container(
                      width: double.minPositive,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5, // Replace with your actual item count
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item $index'),
                            onTap: () {
                              // Add your onTap logic here
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Show List'),
          ),
        ),
      ),
    );
  }
}

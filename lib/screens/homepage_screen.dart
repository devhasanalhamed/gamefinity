import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Explore',
              ),
              Tab(
                text: 'Play',
              ),
            ],
          ),
          actions: [
            IconButton.outlined(
              onPressed: () {},
              icon: const Icon(Icons.gamepad_outlined),
            ),
            IconButton.outlined(
              onPressed: () {},
              icon: const Icon(Icons.import_contacts),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: TabBarView(
            children: [
              Icon(Icons.android),
              Icon(Icons.phone_iphone),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

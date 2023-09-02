import 'package:flutter/material.dart';
import 'package:gamefinity/widgets/developer_widget.dart';

class DevelopersScreen extends StatefulWidget {
  const DevelopersScreen({Key? key}) : super(key: key);

  @override
  DevelopersScreenState createState() => DevelopersScreenState();
}

class DevelopersScreenState extends State<DevelopersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developers'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => const DeveloperWidget(),
      ),
    );
  }
}

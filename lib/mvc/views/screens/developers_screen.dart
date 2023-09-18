import 'package:flutter/material.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/models/users_model.dart';
import 'package:gamefinity/core/helpers/api_handler.dart';
import 'package:gamefinity/mvc/views/widgets/developer_widget.dart';
import 'package:provider/provider.dart';

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
        title: Text(S.of(context).developers),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An Error Occure'),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('There are no proudcts yet'),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const DeveloperWidget(),
              ),
            );
          }
        },
      ),
    );
  }
}

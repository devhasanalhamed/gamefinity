import 'package:flutter/material.dart';
import 'package:gamefinity/models/category_model.dart';
import 'package:gamefinity/services/api_handler.dart';
import 'package:gamefinity/widgets/category_widget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoires'),
      ),
      body: FutureBuilder<List<CategoriesModel>>(
          future: APIHandler.getCategories(),
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
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const CategoryWidget()),
              );
            }
          }),
    );
  }
}

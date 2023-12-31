import 'package:flutter/material.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/models/categories_model.dart';
import 'package:gamefinity/core/helpers/api_handler.dart';
import 'package:gamefinity/mvc/views/widgets/category_widget.dart';
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
        title: Text(S.of(context).categories),
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
              return Center(
                child: Text(S.of(context).errorWhileFetching),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text(S.of(context).itIsEmpty),
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

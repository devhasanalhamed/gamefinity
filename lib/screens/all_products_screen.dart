import 'package:flutter/material.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:gamefinity/widgets/product_widget.dart';

class AllProductsScreen extends StatelessWidget {
  final List<ProductsModel> productsList;
  const AllProductsScreen({
    Key? key,
    required this.productsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All products'),
      ),
      body: productsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              itemCount: productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return ProductWidget(
                  title: productsList[index].title!,
                  imgUrl: productsList[index].images![0],
                );
              },
            ),
    );
  }
}

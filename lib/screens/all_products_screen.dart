import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gamefinity/helpers/size_config.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:gamefinity/services/api_handler.dart';
import 'package:gamefinity/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<ProductsModel> productsList = [];
  int limit = 10;
  bool _isLimit = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(
      () async {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          limit += 10;
          log('$limit');
          if (limit == 200) {
            _isLimit = true;
            setState(() {});
            return;
          }
          await getData();
        }
      },
    );
  }

  Future<void> getData() async {
    productsList = await APIHandler.getAllProducts(limit: '$limit');
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: productsList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    GridView.builder(
                      itemCount: productsList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: SizeConfig.screenWidth! ~/ 150,
                        mainAxisExtent: 280,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: productsList[index],
                          child: const ProductWidget(),
                        );
                      },
                    ),
                    if (!_isLimit)
                      const CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

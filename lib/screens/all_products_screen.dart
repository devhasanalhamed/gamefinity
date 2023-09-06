import 'package:flutter/material.dart';
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
  bool _isLoading = false;
  bool _isLimit = false;

  final ScrollController _scrollcontroller = ScrollController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollcontroller.addListener(
      () async {
        if (_scrollcontroller.position.pixels ==
            _scrollcontroller.position.maxScrollExtent) {
          _isLoading = true;
          limit += 10;
          await getData();
          _isLoading = false;
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
    _scrollcontroller.dispose();
    super.dispose();
  }

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
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    controller: _scrollcontroller,
                    itemCount: productsList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productsList[index],
                        child: const ProductWidget(),
                      );
                    },
                  ),
                  const CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
    );
  }
}

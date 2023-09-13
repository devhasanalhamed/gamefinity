import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/core/helpers/size_config.dart';
import 'package:gamefinity/mvc/models/products_model.dart';
import 'package:gamefinity/mvc/views/screens/all_products_screen.dart';
import 'package:gamefinity/core/helpers/api_handler.dart';
import 'package:gamefinity/mvc/views/widgets/product_widget.dart';
import 'package:gamefinity/mvc/views/widgets/sale_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late TextEditingController textEditingController;
  late SwiperController swiperController;
  late Future<List<ProductsModel>> fetchProducts;

  @override
  void initState() {
    textEditingController = TextEditingController();
    swiperController = SwiperController();
    fetchProducts = APIHandler.getAllProducts(limit: '3');

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    swiperController.dispose();
    super.dispose();
  }

  List<ProductsModel> productsList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical! * 2),
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: S.of(context).search,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Theme.of(context).cardColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical! * 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 25,
                    child: AspectRatio(
                      aspectRatio: 2 / 1,
                      child: Swiper(
                        itemCount: 3,
                        itemBuilder: (ctx, index) => const SaleWidget(),
                        pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            activeColor: Colors.red,
                            color: Colors.white,
                          ),
                        ),
                        controller: swiperController,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).all_games),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const AllProductsScreen(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<ProductsModel>>(
                    future: fetchProducts,
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
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: SizeConfig.screenWidth! ~/ 150,
                            mainAxisExtent: 280,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider.value(
                              value: snapshot.data![index],
                              child: const ProductWidget(),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

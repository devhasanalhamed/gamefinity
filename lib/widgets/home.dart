import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/helpers/size_config.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:gamefinity/screens/all_products_screen.dart';
import 'package:gamefinity/services/api_handler.dart';
import 'package:gamefinity/widgets/product_widget.dart';
import 'package:gamefinity/widgets/sale_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  List<ProductsModel> productsList = [];
  @override
  void didChangeDependencies() {
    print('didChanged Triggered');
    getData();
    super.didChangeDependencies();
  }

  Future<void> getData() async {
    productsList = await APIHandler.getAllProducts(limit: '3');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 18.0),
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Search',
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
          const SizedBox(height: 18.0),
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
                        autoplay: true,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('All Games 🔥'),
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
                    future: APIHandler.getAllProducts(limit: '3'),
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
                                child: const ProductWidget());
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

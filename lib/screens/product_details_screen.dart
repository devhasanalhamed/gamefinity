import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/global/theme.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:gamefinity/services/api_handler.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  const ProductDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final titleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  ProductsModel? productsModel;
  bool isError = false;
  String errorMessage = '';

  Future<void> getProductInfo() async {
    try {
      productsModel = await APIHandler.getProductByID(id: '${widget.id}');
    } catch (error) {
      isError = true;
      errorMessage = error.toString();
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: isError
            ? Center(
                child: Text(
                  'An error has occured: $errorMessage',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              )
            : productsModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 18.0),
                        const BackButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${productsModel!.category!.name}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      productsModel!.title!,
                                      textAlign: TextAlign.start,
                                      style: titleStyle,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                        text: '\$',
                                        style: const TextStyle(
                                          fontSize: 25.0,
                                          color:
                                              Color.fromRGBO(33, 150, 243, 1),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '${productsModel!.price!}',
                                            style: TextStyle(
                                              color: lightTextColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18.0)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemCount: productsModel!.images!.length,
                            itemBuilder: (context, index) {
                              return FancyShimmerImage(
                                imageUrl: productsModel!.images![index],
                                boxFit: BoxFit.fill,
                              );
                            },
                            autoplay: false,
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                activeColor: Colors.red,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: titleStyle,
                              ),
                              const SizedBox(height: 18.0),
                              Text(
                                productsModel!.description!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

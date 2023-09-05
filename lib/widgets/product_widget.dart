import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/models/products_model.dart';
import 'package:gamefinity/screens/product_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  ProductWidgetState createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final ProductsModel productsModelProvider =
        Provider.of<ProductsModel>(context);
    final size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child:  ProductDetailsScreen(id: productsModelProvider.id!),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: RichText(
                      text:  TextSpan(
                        text: '\$',
                        style: const TextStyle(
                          color: Color.fromRGBO(33, 150, 243, 1),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${productsModelProvider.price}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.favorite),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(
                imageUrl: productsModelProvider.images![0],
                height: size.height * 0.2,
                width: double.infinity,
                boxFit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                productsModelProvider.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01)
          ],
        ),
      ),
    );
  }
}

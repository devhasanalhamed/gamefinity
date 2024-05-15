import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/core/helpers/api_handler.dart';
import 'package:gamefinity/core/helpers/size_config.dart';
import 'package:gamefinity/features/game/logic/game_view_model.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/controllers/settings_provider.dart';
import 'package:gamefinity/mvc/models/products_model.dart';
import 'package:gamefinity/mvc/views/screens/all_products_screen.dart';
import 'package:gamefinity/mvc/views/widgets/sale_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
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
          TextButton(
            onPressed: () {
              final pro = Provider.of<GameViewModel>(context, listen: false);
              pro.fetchGamesList();
            },
            child: Text('data'),
          ),
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
              suffixIcon: const Icon(LucideIcons.search),
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
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const AllProductsScreen(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    child: SizedBox(
                      height: SizeConfig.safeBlockVertical! * 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).all_games,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Provider.of<SettingsProvider>(context,
                                            listen: false)
                                        .local !=
                                    'en'
                                ? LucideIcons.arrowLeftCircle
                                : LucideIcons.arrowRightCircle,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
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
                        return Center(
                          child: Text(S.of(context).errorWhileFetching),
                        );
                      } else if (snapshot.data == null) {
                        return Center(
                          child: Text(S.of(context).itIsEmpty),
                        );
                      } else {
                        return Consumer<GameViewModel>(
                          builder: (context, gameProvider, child) =>
                              GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: gameProvider.gameList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: SizeConfig.screenWidth! ~/ 150,
                              mainAxisExtent: 280,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(gameProvider.gameList
                                        .elementAt(index)
                                        .backgroundImage),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    gameProvider.gameList.elementAt(index).name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
